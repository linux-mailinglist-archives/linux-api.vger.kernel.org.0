Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B478838CE78
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 22:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhEUUCZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 16:02:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229916AbhEUUCY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 16:02:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LJXTrJ029104;
        Fri, 21 May 2021 16:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=K59RhIwEEWnQcIteRBJOyIFsGYeKYqR866/ziffc5F0=;
 b=hLfRAjb/dGztkS5bFECtTgqzB5LJMQzmDROgh/AKBoLjId6zCouUQyAa8/sAvYo0yZdt
 eyH50PM/LI2/DSgpCOI2X+yq6rX7qwt+d3sHAmApHGXTpWu19BzHMfI5gH7TsEvq5iJs
 oER1iVoMjUnEaqcC/1gJuzCpPNoGo/WyfMs8Dgm3iQA4SxG0pxxbo24KYzmh8FsdVf8l
 DVGRHs8sZ3MTnqGFd7Lt5Pz7PzpdpVoBZisgUrLbmaFI+eJn8xMo2g1BPUJiQaJFQEMx
 Jw4sqvCQqomr3itfcYmH6Lm5y6BiuQuSZp34j77wrZ73YfYwjw/bWvN09tRSBPhq/O/u AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38pjfj9bf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 16:00:41 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14LJlXPY075988;
        Fri, 21 May 2021 16:00:41 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38pjfj9bej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 16:00:41 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14LJpkwT010886;
        Fri, 21 May 2021 20:00:40 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 38j5xaesej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 20:00:40 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14LK0dTd37290306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 20:00:39 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A430112062;
        Fri, 21 May 2021 20:00:39 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EEEE112063;
        Fri, 21 May 2021 20:00:37 +0000 (GMT)
Received: from TP480.linux.ibm.com (unknown [9.160.176.31])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 May 2021 20:00:37 +0000 (GMT)
References: <20200611081203.995112-1-npiggin@gmail.com>
 <20210518231331.GA8464@altlinux.org>
 <1621385544.nttlk5qugb.astroid@bobo.none>
 <1621400263.gf0mbqhkrf.astroid@bobo.none> <87a6oo4312.fsf@linux.ibm.com>
 <87k0nr6ezw.fsf@oldenburg.str.redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Matheus Castanho <msc@linux.ibm.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Matheus Castanho via Libc-alpha <libc-alpha@sourceware.org>,
        Nicholas Piggin <npiggin@gmail.com>, musl@lists.openwall.com,
        "Dmitry V. Levin" <ldv@altlinux.org>, linux-api@vger.kernel.org,
        libc-dev@lists.llvm.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Linux powerpc new system call instruction and ABI
In-reply-to: <87k0nr6ezw.fsf@oldenburg.str.redhat.com>
Date:   Fri, 21 May 2021 17:00:36 -0300
Message-ID: <87eedz3li3.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k9YXHXmkCEfCHht_gu-gXPH1T7WlSSvg
X-Proofpoint-GUID: qW-bxH6-TgC73IAxn1qdzi1gG8N17u_Y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_09:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210103
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Florian Weimer <fweimer@redhat.com> writes:

> * Matheus Castanho via Libc-alpha:
>
>> From: Nicholas Piggin <npiggin@gmail.com>
>> Subject: [PATCH 1/1] powerpc: Fix handling of scv return error codes
>>
>> When using scv on templated ASM syscalls, current code interprets any
>> negative return value as error, but the only valid error codes are in
>> the range -4095..-1 according to the ABI.
>>
>> Reviewed-by: Matheus Castanho <msc@linux.ibm.com>
>
> Please reference bug 27892 in the commit message.  I'd also appreciate a
> backport to the 2.33 release branch (where you need to add NEWS manually
> to add the bug reference).

No problem. [BZ #27892] appended to the commit title. I'll make sure to
backport to 2.33 as well.

Thanks

--
Matheus Castanho
