Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA6F274395
	for <lists+linux-api@lfdr.de>; Tue, 22 Sep 2020 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIVN40 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Sep 2020 09:56:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726653AbgIVN4Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Sep 2020 09:56:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08MDhlnA017604;
        Tue, 22 Sep 2020 09:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=7GKrSmqkYAC7wLfUIDBY2wTrdJBOxyfdYmxuWzNiUbk=;
 b=ZpiaqIPFgie4DRCixVjeEmo7zTB5p000jDyv8k55epI+sn+BaHNqcwqJRUAgYoCdveRC
 ZifQjVGDZVN+kvmGB2juRJiX4UAJG0ctYZnzwj4+gh0Ezv8/yhIblDXCxEmpwKEhPqeo
 7PeL7t+KsJCNqGX4gLbl5wu1abCK/CwV4dlveMRAOJ5CEoE1BFm+Ls9WXca7E3p0ebFN
 KurFuUhFJfyHdGXVZi/qSGuFS2LnDdqVSgHAS/myXx95X7rmT80MCZr7Y/5nP+UPoeTj
 CQNqdczUPvB4o8Q2tVDBXs/CYdouvGK8/kVCgWAPhSwh8eavTXGXdQAnodA6b4SHkmTk uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33qjdfrdhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 09:56:19 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08MDiLwb021599;
        Tue, 22 Sep 2020 09:56:18 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33qjdfrdgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 09:56:18 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08MDpSYr003827;
        Tue, 22 Sep 2020 13:56:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 33n98gsnae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 13:56:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08MDuDLq29491652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 13:56:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E92BFA404D;
        Tue, 22 Sep 2020 13:56:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D674A4040;
        Tue, 22 Sep 2020 13:56:12 +0000 (GMT)
Received: from thinkpad (unknown [9.171.5.34])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 22 Sep 2020 13:56:12 +0000 (GMT)
Date:   Tue, 22 Sep 2020 15:56:11 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jan =?UTF-8?B?SMO2cHBuZXI=?= <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-api@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Ways to deprecate
 /sys/devices/system/memory/memoryX/phys_device ?
Message-ID: <20200922155611.379373f7@thinkpad>
In-Reply-To: <21852ccb-bd06-9281-7c8e-485ec02f2883@redhat.com>
References: <21852ccb-bd06-9281-7c8e-485ec02f2883@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_12:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220106
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 10 Sep 2020 12:20:34 +0200
David Hildenbrand <david@redhat.com> wrote:

> Hi everybody,
> 
> I was just exploring how /sys/devices/system/memory/memoryX/phys_device
> is/was used. It's one of these interfaces that most probably never
> should have been added but now we are stuck with it.
> 
> "phys_device" was used on s390x in older versions of lsmem[2]/chmem[3],
> back when they were still part of s390x-tools. They were later replaced
> [5] by the variants in linux-utils. For example, RHEL6 and RHEL7 contain
> lsmem/chmem from s390-utils. RHEL8 switched to versions from util-linux
> on s390x [4].
> 
> "phys_device" was added with sysfs support for memory hotplug in commit
> 3947be1969a9 ("[PATCH] memory hotplug: sysfs and add/remove functions")
> in 2005. It always returned 0.
> 
> s390x started returning something != 0 on some setups (if sclp.rzm is
> set by HW) in 2010 via commit 57b552ba0b2f("memory hotplug/s390: set
> phys_device").
> 
> For s390x, it allowed for identifying which memory block devices belong
> to the same memory increment (RZM). Only if all memory block devices
> comprising a single memory increment were offline, the memory could
> actually be removed in the hypervisor.
> 
> Since commit e5d709bb5fb7 ("s390/memory hotplug: provide
> memory_block_size_bytes() function") in 2013 a memory block devices
> spans at least one memory increment - which is why the interface isn't
> really helpful/used anymore (except by old lsmem/chmem tools).

Correct, so I do not see any problem for s390 with removing / changing
that for the upstream kernel. BTW, that commit also gave some relief
on the scaling issue, at least for s390. With increasing total memory
size, we also have increasing increment and thus memory block size.

Of course, that also has some limitations, IIRC max. 1 GB increment
size, but still better than the 256 MB default size.

> 
> There were once RFC patches to make use of it in ACPI, but it could be
> solved using different interfaces [1].
> 
> 
> While I'd love to rip it out completely, I think it would break old
> lsmem/chmem completely - and I assume that's not acceptable. I was
> wondering what would be considered safe to do now/in the future:
> 
> 1. Make it always return 0 (just as if "sclp.rzm" would be set to 0 on
> s390x). This will make old lsmem/chmem behave differently after
> switching to a new kernel, like if sclp.rzm would not be set by HW -
> AFAIU, it will assume all memory is in a single memory increment. Do we
> care?

No, at least not until that kernel change would be backported to some
old distribution level where we still use lsmem/chmem from s390-tools.
Given that this is just some clean-up w/o any functional benefit, and
hopefully w/o any negative impact, I think we can safely assume that no
distributor will do that "just for fun".

Even if there would be good reasons for backports, then I guess we also
have good reasons for backporting / switching to the util-linux version
of lsmem / chmem for such distribution levels. Alternatively, adjust the
s390-tools lsmem / chmem there.

But I would rather "rip it out completely" than just return 0. You'd
need some lsmem / chmem changes anyway, at least in case this would
ever be backported.

> 2. Restrict it to s390x only. It always returned 0 on other
> architectures, I was not able to find any user.
> 
> I think 2 should be safe to do (never used on other archs). I do wonder
> what the feelings are about 1.

Please don't add any s390-specific workarounds here, that does not
really sound like a clean-up, rather the opposite.

That being said, I do not really see the benefit of this change at
all. As Michal mentioned, there really should be some more fundamental
change. And from the rest of this thread, it also seems that phys_device
usage might not be the biggest issue here.
