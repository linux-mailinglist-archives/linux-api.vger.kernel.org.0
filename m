Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5A3100D33
	for <lists+linux-api@lfdr.de>; Mon, 18 Nov 2019 21:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRUfR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 Nov 2019 15:35:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43610 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKRUfQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 Nov 2019 15:35:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIKY6mi144903;
        Mon, 18 Nov 2019 20:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=/m3kaDVW1sMY9brAV1q+FPeUQEVlhy04QwMV4rIKN7c=;
 b=WPVQazv5GxJ695xUzInhmfhfdQ9BBih+cryPlMonblaBi5zijCQsMHi4sTTv3KgusZnf
 +LTQRuOFEYOW25I777Kk7DJRsNRGhoV/2RwHmFw/H4jiN0pVAhz+WeSHozhr5kxpo0Nv
 jKgEyoKUu4omzr7YHCfWfucZMWTqIOwJc0N794oaw4RGvXPKaqmFwjhYEbPBEKttCkPf
 UC1qDilSQUoDxGknMhIdF04BIgiq+dZF7EVnNQ3Va4CCqcpSC9K8f54MjnoTbSNiplAu
 E9wpKfdaWaORwi6SEZgybPeJmzsCWtOAwMFJ/m+4r6/gNR1o1h+WwWJAmFMm7WFYg/Yn Iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wa8htjsmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 20:34:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIKXV65164107;
        Mon, 18 Nov 2019 20:34:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wbxm33gdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 20:34:51 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAIKYlMt006102;
        Mon, 18 Nov 2019 20:34:47 GMT
Received: from prakashs-mbp-2.lan (/98.248.138.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 12:34:47 -0800
Subject: Re: [RESEND RFC PATCH 0/1] CAP_SYS_NICE inside user namespace
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>
References: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
 <CAG48ez3HfUx2aRvqR_bWnGoTshrHnUzxUNt7K6Sv7cqtPDWaWw@mail.gmail.com>
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
Message-ID: <9a63f7ae-562e-67a6-8f40-050c58c08933@oracle.com>
Date:   Mon, 18 Nov 2019 12:34:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez3HfUx2aRvqR_bWnGoTshrHnUzxUNt7K6Sv7cqtPDWaWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180177
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 11/18/19 11:36 AM, Jann Horn wrote:
> On Mon, Nov 18, 2019 at 6:04 PM Prakash Sangappa
> <prakash.sangappa@oracle.com> wrote:
>> Some of the capabilities(7) which affect system wide resources, are ineffective
>> inside user namespaces. This restriction applies even to root user( uid 0)
>> from init namespace mapped into the user namespace. One such capability
>> is CAP_SYS_NICE which is required to change process priority. As a result of
>> which the root user cannot perform operations like increase a process priority
>> using -ve nice value or set RT priority on processes inside the user namespace.
>> A workaround to deal with this restriction is to use the help of a process /
>> daemon running outside the user namespace to change process priority, which is
>> a an inconvenience.
> What is the goal here, in the big picture? Is your goal to allow
> container admins to control the priorities of their tasks *relative to
> each other*, or do you actually explicitly want container A to be able
> to decide that its current workload is more timing-sensitive than
> container B's?

It is more the latter. Admin should be able to explicitly decide that 
container A
workload is to be given priority over other containers.
