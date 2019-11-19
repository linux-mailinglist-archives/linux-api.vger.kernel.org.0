Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3072F10105D
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2019 01:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKSAtI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 Nov 2019 19:49:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46922 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfKSAtI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 Nov 2019 19:49:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ0htno109073;
        Tue, 19 Nov 2019 00:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 references : to : cc : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=1YpNQImsbOY2XvuXHptOUdXQSplh3oG1AGe2pyP9gNU=;
 b=QjE+xGiItWVREUg96rzbIILSkWZjn6IuaPtImcl6XeHJBOGvCt/UvC3rKySCmz6JEmql
 hphWm3+SG6u/iu5rCUSLt30BzACcm0ObIJpLWzLt5jNHQNf68GyDXmffz52WA2irl7DO
 XD/8EijyXGrmjqdwhKIkfiDpnaC33Wx7HjF52Q8S39kl3pZD8Q0EpVBmra1tP5ld3Gcf
 c9MGS42IgfIVQhaoliZg7t0I+YqxPt7vS0VZDd9bvEoK548VPbaqRZNHIhP8cGWVqHPm
 Cda/Uwm1bJSieTg0L0gq6ZedCTJxckLitq2zkhSApH2vEI9mTyXP9y9ZRVXzbiKI4Yjb Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rqbn08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 00:48:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ0lrEe020048;
        Tue, 19 Nov 2019 00:48:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wc0affd4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 00:48:36 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ0mYhr032125;
        Tue, 19 Nov 2019 00:48:34 GMT
Received: from [10.132.95.199] (/10.132.95.199)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 16:48:33 -0800
Reply-To: prakash.sangappa@oracle.com
Subject: Re: [RESEND RFC PATCH 1/1] Selectively allow CAP_SYS_NICE capability
 inside user namespaces
References: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
 <1574096478-11520-2-git-send-email-prakash.sangappa@oracle.com>
 <CAG48ez1i9LUd2DPoP9na9OyqXDZVRJZQqBbS1H6Dz_h7mtJ=Mw@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>
From:   "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <9b2dd6f5-5b0b-9c9b-e853-5795c352e092@oracle.com>
Date:   Mon, 18 Nov 2019 16:46:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez1i9LUd2DPoP9na9OyqXDZVRJZQqBbS1H6Dz_h7mtJ=Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190003
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 11/18/2019 11:30 AM, Jann Horn wrote:
> On Mon, Nov 18, 2019 at 6:04 PM Prakash Sangappa
> <prakash.sangappa@oracle.com> wrote:
>> Allow CAP_SYS_NICE to take effect for processes having effective uid of a
>> root user from init namespace.
> [...]
>> @@ -4548,6 +4548,8 @@ int can_nice(const struct task_struct *p, const int nice)
>>          int nice_rlim = nice_to_rlimit(nice);
>>
>>          return (nice_rlim <= task_rlimit(p, RLIMIT_NICE) ||
>> +               (ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE) &&
>> +               uid_eq(current_euid(), GLOBAL_ROOT_UID)) ||
>>                  capable(CAP_SYS_NICE));
> I very strongly dislike tying such a feature to GLOBAL_ROOT_UID.
> Wouldn't it be better to control this through procfs, similar to
> uid_map and gid_map? If you really need an escape hatch to become
> privileged outside a user namespace, then I'd much prefer a file
> "cap_map" that lets someone with appropriate capabilities in the outer
> namespace write a bitmask of capabilities that should have effect
> outside the container, or something like that. And limit that to bits
> where that's sane, like CAP_SYS_NICE.

Sounds reasonable. Adding a 'cap_map' file to user namespace, would give 
more control. We could allow the  capability in 'cap_map' to take effect 
only if corresponding capability is enabled for the user inside the user 
namespace Ex uid 0. Start with support for CAP_SYS_NICE?


>
> If we tie features like this to GLOBAL_ROOT_UID, more people are going
> to run their containers with GLOBAL_ROOT_UID. Which is a terrible,
> terrible idea. GLOBAL_ROOT_UID gives you privilege over all sorts of
> files that you shouldn't be able to access, and only things like mount
> namespaces and possibly LSMs prevent you from exercising that
> privilege. GLOBAL_ROOT_UID should only ever be given to processes that
> you trust completely.

Agreed.

