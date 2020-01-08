Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60353134ED5
	for <lists+linux-api@lfdr.de>; Wed,  8 Jan 2020 22:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgAHVZf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Jan 2020 16:25:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39742 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgAHVZe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Jan 2020 16:25:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 008LI7Ef104982;
        Wed, 8 Jan 2020 21:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=p+VKUmFTYouUcdSlYAoM9Pr3W2UblwpfU8rrZp0oNbE=;
 b=CwCADtJTMEKq6lcc8O6ASV2uqvwRQzEC4ADL5xIgzmCExGamfmNc0reAl1octn6ouiGY
 hw9JkzGCjacVhZ8ieSCRgkUoAvRF8tXAi8E4F0VIDmI1Z0EOGFKpoukC9IbX2k60zKC9
 +06h9V7bbcQUFux6TOuMDtOEnmUxRuJdmb3JM+BgVvDsFp+CuME5SaRp2Cr5D+KY4NNX
 iMpP1k4VYb+C8objoHUHgAjA2b/gYN/Eaxqjrv77lUXg0lfRHGO3BZ25fALUZHDEQn44
 /23BKnwijKtX7Gwow4D7AS+5ZGpp+ynmMN3iHXmUSAQdpJ8OloVgIVZ+LB60OyGRkIQ2 IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xaj4u6s71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 21:24:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 008LJW5U078547;
        Wed, 8 Jan 2020 21:24:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xcpctgwug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 21:24:58 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 008LOuTG001519;
        Wed, 8 Jan 2020 21:24:56 GMT
Received: from [10.132.95.199] (/10.132.95.199)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jan 2020 13:24:56 -0800
Subject: Re: [RESEND RFC PATCH 1/1] Selectively allow CAP_SYS_NICE capability
 inside user namespaces
To:     "Eric W. Biederman" <ebiederm@xmission.com>
References: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
 <1574096478-11520-2-git-send-email-prakash.sangappa@oracle.com>
 <87wobszzqi.fsf@x220.int.ebiederm.org>
 <0d7fb84d-e7e8-c442-37a3-23b036fdf12c@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, serge@hallyn.com
From:   "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <b231b9b4-c37d-1d9f-7054-1b4be41302b4@oracle.com>
Date:   Wed, 8 Jan 2020 13:23:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <0d7fb84d-e7e8-c442-37a3-23b036fdf12c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080167
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 11/21/2019 05:45 PM, Prakash Sangappa wrote:
>
>
> On 11/21/19 1:27 PM, ebiederm@xmission.com wrote:
>> Prakash Sangappa <prakash.sangappa@oracle.com> writes:
<..>
>> 2) If I read the other thread correctly there was talk about setting the
>>     nice levels of processes in other containers.  Ouch!
>
> No not in other containers. Only on processes within the container 
> which has this capability. The use case is to use it in a container 
> with user namespace and pid namespace. So no processes from other 
> containers should be visible. Necessary checks should be added?.
>
>
>>
>>     The only thing I can think that makes any sense at all is to allow
>>     setting the nice levels of the processes in your own container.
>
> Yes that is the intended use.
>
>>
>>     I can totally see having a test to see if a processes credentials 
>> are
>>     in the caller's user namespace or a child of caller's user namespace
>>     and allowing admin level access if the caller has the appropriate
>>     caps in their user namespace.
>
> Ok
>
>>     But in this case I don't see anything preventing the admin in a
>>     container from using the ordinary nice levels on a task. You are
>>     unlocking the nice levels reserved for the system administrator
>>     for special occassions.   I don't see how that makes any sense
>>     to do from inside a container.
>
> But this is what seems to be lacking. A container could have some 
> critical processes running which need to run at a higher priority.

Any comments about this? What would be the recommendation for dealing 
with such a requirement?


