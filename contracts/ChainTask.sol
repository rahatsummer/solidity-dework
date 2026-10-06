
// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract ChainTask{
    struct Task{
        uint256 id;
        string content;
        bool completed;
        uint256 createdAt;
    }

    mapping(address => Task[]) private _tasks;
    mapping(address => uint256) private _nextId;

    event TaskCreated(address indexed owner, uint256 indexed id, string content);
    event TaskToggled(address indexed owner, uint256 indexed id, bool completed);
    event TaskDeleted(address indexed owner, uint256 indexed id);

    error EmptyContent();
    error TaskNotFound(uint256 id);

    function createTask(string calldata _content) external {
        if(bytes(_content).length == 0) revert EmptyContent();

        uint256 newId = _nextId[msg.sender];

        _tasks[msg.sender].push(
            Task({
                id: newId,
                content: _content,
                completed: false,
                createdAt: block.timestamp

                // Task[] = Array of tasks,
                // _tasks = Mapping: Address → Task[]
            })
        );

        _nextId[msg.sender] = newId + 1;

        emit TaskCreated(msg.sender, newId, _content);
    }

    function toggleTask(uint256 _id) external {
        uint256 index = _findIndex(msg.sender, _id);

        Task storage task = _tasks[msg.sender][index]; // Get all tasks belonging to the current user. Get one specific task from that user's task array.
        // storage means task is a reference to the actual task stored permanently on the blockchain.
        
        task.completed = !task.completed;

        emit TaskToggled(msg.sender, _id, task.completed);
    }

    function deleteTask (uint256 _id) external {
         uint256 index = _findIndex(msg.sender, _id);

         Task[] storage list = _tasks[msg.sender];

         list[index] = list[list.length -1 ];

         list.pop();

         emit TaskDeleted(msg.sender, _id);
    }

    function getMyTask() external view returns(Task[] memory){
        return _tasks[msg.sender];
    }

    // returns all tasks belonging to any address provided as _owner.
    function getTaskOf(address _owner) external view returns(Task[] memory){
        return _tasks[_owner];
    }

    function taskGetCount(address _owner) external view returns(uint256){
        return _tasks[_owner].length;
    }

    function _findIndex(address _owner, uint256 _id) private view returns (uint256){
        Task[] storage list = _tasks[_owner];

        for(uint256 i=0; i < list.length; i++){
            if(list[i].id == _id){
                return i;
            }
        }

        revert TaskNotFound(_id);
    }
}