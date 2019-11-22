Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA34F105E67
	for <lists+linux-api@lfdr.de>; Fri, 22 Nov 2019 02:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKVByk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Nov 2019 20:54:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47576 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVByj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Nov 2019 20:54:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM1sIoL121555;
        Fri, 22 Nov 2019 01:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=h098rWglCkWR1LdZtyG2oxKaMO6+fTPcAneswQCztKA=;
 b=bsIhPtmITYCvuB9CmcJOaeiqqXIsplpKNvmWRC9hRS8ttG0hRXCINa9nXOpSaAnjsMRO
 jzYQ3cye5hPVug6OJBz/CTpPBnYfDVbDjhmd94oFPywKTFZggEN+Eu2aTmociWwmnj8U
 QB1iN5V1Ny8gQiRZtZ/Z43jdtXKctBtt551T7KyIsALfvv+q6g4n8CmTUSx/2xgFuA1k
 Dd4BSx21YFKp0BI+QLtUrb7jl68G30+l14D3myoVxuenNN7MiATvCHzweHC2l0Ix87Jy
 B5yrLhnWZjjq7GZrJB2b6IMo2eDbA5ctALrPPDJC8yaM4W25IiEDsOWDtM6BC2Z80PX+ nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wa92q7tus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 01:54:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM1s1NM087198;
        Fri, 22 Nov 2019 01:54:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wd47y0m8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 01:54:17 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAM1sFVT006736;
        Fri, 22 Nov 2019 01:54:16 GMT
Received: from prakashs-mbp-2.lan (/98.248.138.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 17:54:15 -0800
Subject: Re: [RESEND RFC PATCH 0/1] CAP_SYS_NICE inside user namespace
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>
References: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
 <CAG48ez3HfUx2aRvqR_bWnGoTshrHnUzxUNt7K6Sv7cqtPDWaWw@mail.gmail.com>
 <9a63f7ae-562e-67a6-8f40-050c58c08933@oracle.com>
 <c7949242-385f-3256-b290-87640acd0577@metux.net>
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
Message-ID: <4593138d-421e-5770-6dd5-e31f103911c5@oracle.com>
Date:   Thu, 21 Nov 2019 17:54:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c7949242-385f-3256-b290-87640acd0577@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220015
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 11/21/19 10:33 AM, Enrico Weigelt, metux IT consult wrote:
> On 18.11.19 21:34, Prakash Sangappa wrote:
>
>> It is more the latter. Admin should be able to explicitly decide that  container A
>> workload is to be given priority over other containers.
> I guess, you're talking about the host's admin, correct ?

Yes, Specifically host's admin decides which container gets the 
privilege to increase priority of processes inside that container.

>
> Shouldn't this already be possibly by tweaking the container's cgroups ?

Don't think so. The use case is that admin/user inside the container 
needs to be able to increase the priority of some the critical processes 
running in the container.

>
>
> --mtx
>

