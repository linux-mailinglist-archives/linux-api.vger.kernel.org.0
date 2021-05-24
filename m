Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E438F38F470
	for <lists+linux-api@lfdr.de>; Mon, 24 May 2021 22:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhEXUfY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 May 2021 16:35:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232929AbhEXUfY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 May 2021 16:35:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14OK3nfj185241;
        Mon, 24 May 2021 16:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=FZyIYp++kLFd7+FZB7WEKrumdZ2aEQqCESOGbyT5Kxg=;
 b=gzA11SQ/YmnbE/fTjFn3zFl6e4vEnPt3lXbRRoYCVuYBcdi6mi3FYoUOLGIL3LQaVTlO
 MZ8ZBOV6Ku6HNxyalbBbGi1F5QVVAYJ5T8LN5AWOVAjrr0dXiElnI/OBa8fEFf+rzKQZ
 JgmyOdUyvrWc8UaTObizkwtGwemhCKutQVf6oUj3u+gEp0QQ6TbJWeeU0nf2g+rjP29M
 i8/T0hr5RsrAgO1+qUM/0xyRjIzR1cRluaiUYFUgwHpL+niwB/VkFKfDqzrL1sbk3iPK
 p6iZfxNVMMQW2Rw4QB0xoBS0CE57L2QBcMq28SnKQWrMajB5iDt5/0cqP6Sn3DriDBIg yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rjjp0yqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 16:33:32 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14OK3ohP185380;
        Mon, 24 May 2021 16:33:31 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rjjp0yqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 16:33:31 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14OKHPkF018856;
        Mon, 24 May 2021 20:33:30 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 38psk99ta7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 20:33:30 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14OKXTHR21496212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 20:33:29 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8741CBE053;
        Mon, 24 May 2021 20:33:29 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 743DFBE058;
        Mon, 24 May 2021 20:33:26 +0000 (GMT)
Received: from TP480.linux.ibm.com (unknown [9.65.94.141])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 May 2021 20:33:26 +0000 (GMT)
References: <20200611081203.995112-1-npiggin@gmail.com>
 <20210518231331.GA8464@altlinux.org>
 <1621385544.nttlk5qugb.astroid@bobo.none>
 <1621400263.gf0mbqhkrf.astroid@bobo.none> <87a6oo4312.fsf@linux.ibm.com>
 <87k0nr6ezw.fsf@oldenburg.str.redhat.com> <87eedz3li3.fsf@linux.ibm.com>
 <20210521205204.GA24309@altlinux.org> <87a6ok2uxx.fsf@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Matheus Castanho <msc@linux.ibm.com>
To:     Matheus Castanho <msc@linux.ibm.com>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Florian Weimer <fweimer@redhat.com>,
        Matheus Castanho via Libc-alpha <libc-alpha@sourceware.org>,
        linux-api@vger.kernel.org, musl@lists.openwall.com,
        Nicholas Piggin <npiggin@gmail.com>, libc-dev@lists.llvm.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Linux powerpc new system call instruction and ABI
In-reply-to: <87a6ok2uxx.fsf@linux.ibm.com>
Date:   Mon, 24 May 2021 17:33:24 -0300
Message-ID: <87im3727or.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ER5I-gxskURqA0q20yF-IAm9RBLnInl_
X-Proofpoint-ORIG-GUID: eAxo70sIvYvIrIANrjlNpsJk6RtF1TSC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_09:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105240118
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Matheus Castanho <msc@linux.ibm.com> writes:

> Dmitry V. Levin <ldv@altlinux.org> writes:
>
>> On Fri, May 21, 2021 at 05:00:36PM -0300, Matheus Castanho wrote:
>>> Florian Weimer <fweimer@redhat.com> writes:
>>> > * Matheus Castanho via Libc-alpha:
>>> >> From: Nicholas Piggin <npiggin@gmail.com>
>>> >> Subject: [PATCH 1/1] powerpc: Fix handling of scv return error codes
>>> >>
>>> >> When using scv on templated ASM syscalls, current code interprets any
>>> >> negative return value as error, but the only valid error codes are in
>>> >> the range -4095..-1 according to the ABI.
>>> >>
>>> >> Reviewed-by: Matheus Castanho <msc@linux.ibm.com>
>>> >
>>> > Please reference bug 27892 in the commit message.  I'd also appreciate a
>>> > backport to the 2.33 release branch (where you need to add NEWS manually
>>> > to add the bug reference).
>>>
>>> No problem. [BZ #27892] appended to the commit title. I'll make sure to
>>> backport to 2.33 as well.
>>
>> Could you also mention in the commit message that the change fixes
>> 'signal.gen.test' strace test where it was observed initially?
>
> Sure, no problem. I'll commit it later today.

Since the patch falls into the less-than-15-LOC category and this is
Nick's first contribution to glibc, looks like he doesn't need a
copyright assignment.

Pushed to master as 7de36744ee1325f35d3fe0ca079dd33c40b12267

Backported to 2.33 via commit 0ef0e6de7fdfa18328b09ba2afb4f0112d4bdab4

Thanks,
Matheus Castanho
