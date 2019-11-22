Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FADF105E5D
	for <lists+linux-api@lfdr.de>; Fri, 22 Nov 2019 02:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKVBqg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Nov 2019 20:46:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39068 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVBqg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Nov 2019 20:46:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM1iRN3115334;
        Fri, 22 Nov 2019 01:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=hnvuc3jTrXOhRIAjl5N+6c/vPzfwGWHedFpRIDxERKw=;
 b=H3hPC+otfrlRNB6MwS7rlfQ4IZrzApo37kTlkanXe3cFJ1O7DSNfRhxKb7jbaYWy7NjG
 pV8Gf1tBsqicmFXXkDCxSFyfxTWDXUoEsapTLZxHKDVreHdrnFplwh8U0vOpEJpeIdRm
 LMbtRQaTGuPYXq8lFmyIQZZj3/P5SI7cupnF+zu3fctz3hxAnuP8IREiUGHd+dc5VXbl
 f8rrMMmPVsS12SwUIVBJsAsWciyqJre3QgVmnJ73JFzHmbO30b81Xzi85Bd0mIySNMDA
 Wd0m/uH53dPtUFX6WNRLBXXiPlB5R4FQROR/kzD1q+ER+ObI6W1aL6zP4mPSDenzwOk3 eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wa92q7ta4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 01:46:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM1i1Re062553;
        Fri, 22 Nov 2019 01:46:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wdfrw9aee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 01:46:06 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAM1jxDB017623;
        Fri, 22 Nov 2019 01:46:03 GMT
Received: from prakashs-mbp-2.lan (/98.248.138.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 17:45:59 -0800
Subject: Re: [RESEND RFC PATCH 1/1] Selectively allow CAP_SYS_NICE capability
 inside user namespaces
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, serge@hallyn.com
References: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
 <1574096478-11520-2-git-send-email-prakash.sangappa@oracle.com>
 <87wobszzqi.fsf@x220.int.ebiederm.org>
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
Message-ID: <0d7fb84d-e7e8-c442-37a3-23b036fdf12c@oracle.com>
Date:   Thu, 21 Nov 2019 17:45:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87wobszzqi.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220013
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 11/21/19 1:27 PM, ebiederm@xmission.com wrote:
> Prakash Sangappa <prakash.sangappa@oracle.com> writes:
>
>> Allow CAP_SYS_NICE to take effect for processes having effective uid of a
>> root user from init namespace.
>>
>> Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
>> ---
>>   kernel/sched/core.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 7880f4f..628bd46 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4548,6 +4548,8 @@ int can_nice(const struct task_struct *p, const int nice)
>>   	int nice_rlim = nice_to_rlimit(nice);
>>   
>>   	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE) ||
>> +		(ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE) &&
>> +		uid_eq(current_euid(), GLOBAL_ROOT_UID)) ||
>>   		capable(CAP_SYS_NICE));
>>   }
>>   
>> @@ -4784,7 +4786,9 @@ static int __sched_setscheduler(struct task_struct *p,
>>   	/*
>>   	 * Allow unprivileged RT tasks to decrease priority:
>>   	 */
>> -	if (user && !capable(CAP_SYS_NICE)) {
>> +	if (user && !(ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE) &&
>> +		uid_eq(current_euid(), GLOBAL_ROOT_UID)) &&
>> +		!capable(CAP_SYS_NICE)) {
>>   		if (fair_policy(policy)) {
>>   			if (attr->sched_nice < task_nice(p) &&
>>   			    !can_nice(p, attr->sched_nice))
>
> I remember looking at this before.  I don't remember if I commented.

Thanks for looking at this.

>
> 1) Having GLOBAL_ROOT_UID in a user namespace is A Bad Idea™.
>     Definitely not something we should make special case for.
>     That configuration is almost certainly a privilege escalation waiting
>     to happen.

Mapping root uid 0(GLOBAL_ROOT_UID) from init namespace into a user 
namespace is allowed right now. so the proposal was to extend this to 
allow capabilities like CAP_SYS_NICE to take effect which is lacking.

Understand encouraging use of GLOBAL_ROOT_UID for this purpose may not 
be a good idea.

We could look at other means to grant such capabilities to user 
namespace thru a per process /proc file like 'cap_map' or something as 
suggested in the other thread. What do you think about this approach?

Only privileged user in init namespace gets to add an entry to this 
file. We need to define if this gets inherited by any nested user 
namespaces that get created.



> 2) If I read the other thread correctly there was talk about setting the
>     nice levels of processes in other containers.  Ouch!

No not in other containers. Only on processes with in the container 
which as this capability. The use case is to use it in a container with 
user namespace and pid namespace. So no processes from other containers 
should be visible. Necessary checks should be added?.


>
>     The only thing I can think that makes any sense at all is to allow
>     setting the nice levels of the processes in your own container.

Yes that is the intended use.

>
>     I can totally see having a test to see if a processes credentials are
>     in the caller's user namespace or a child of caller's user namespace
>     and allowing admin level access if the caller has the appropriate
>     caps in their user namespace.

Ok

>     But in this case I don't see anything preventing the admin in a
>     container from using the ordinary nice levels on a task.  You are
>     unlocking the nice levels reserved for the system administrator
>     for special occassions.   I don't see how that makes any sense
>     to do from inside a container.

But this is what seems to be lacking. A container could have some 
critical processes running which need to run at a higher priority.

>
> The design goal of user namespaces (assuming a non-buggy kernel) is to
> ensure user namespaces give a user no more privileges than the user had
> before creating a user namespace.  In this case you are granting a user
> who creates a user namespace the ability to change nice levels on all
> process in the system (limited to users whose uid happens to be
> GLOBAL_ROOT_UID).  But still this is effectively a way to get
> CAP_SYS_NICE back if it was dropped.

Giving privileges to only to those user with root uid from init 
namespace inside the user namespace(GLOBAL_ROOT_UID), or if not using 
GLOBAL_ROOT_UID, then privilege granted thru the /proc mechanism as 
mentioned above.

>
> As a violation of security policy this change simply can not be allowed.
> The entire idiom:  "ns_capable(__task_cred(p)->user_ns, ...)" is a check
> that provides no security.

If the effect of allowing such privileges inside user namespace could be 
controlled with use of Cgroups, even then would it be a concern?

-Prakash
> Eric
>
>
>
>
>
>     
>     
>

