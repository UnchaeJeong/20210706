# list1 = ['나는 행복합니다.\n','나는 불행합니다.\n','코인 망해라\t','주식 대박!!!!','펀드 대박\n']
# list1.append('6')
# list2 = ''.join(list1) # join은 list값을 str 값으로 바꿔줌.
#
# l4 = list2.split('.') #리스트 값 내 .구분자로 원소를 나눠줌. .구분자는 사라짐
# # print(l4)
# # print(list1)
# print(type(list2))
# print(list2.replace("\n"," ").replace("\t","").replace("\r","")) #    .replace는 str에서만 쓰임

# list3 = []
# list3.append(list2)
# # # print(list3)
# #
# str1 = '가|나|다|라|마|바|사|'
# #
# print(str1)
#
# l1 = str1.split('|')
# l2 = list(str1)
# print(l1)
# print(l2)
#
# #1
#
# a = [1,2,3]
# print((type(a)))
#
# #2
#
# # b = list('1234')
# # print(b)
#
#
# def new_print(a,b,c):
#     print('내이름은 '+a + ". "+b +"이죠"+c)
#
#
# new_print(c='코난',a = '탐정',b='A')

num_list1 = [10, 20, 30]
num_list2 = [40, 50, 60]

num_list1.extend(num_list2) #리스트 뒤에 리스트를 붙이는데 쓰임 +=
print(num_list1)
num_list1.append(10) #리스트 뒤에 값을 붙이는데 쓰임
print(num_list1)

num_list1.remove(10)
print(num_list1)
