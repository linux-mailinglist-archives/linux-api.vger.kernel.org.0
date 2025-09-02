Return-Path: <linux-api+bounces-4688-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89707B40ABE
	for <lists+linux-api@lfdr.de>; Tue,  2 Sep 2025 18:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7BD188FE53
	for <lists+linux-api@lfdr.de>; Tue,  2 Sep 2025 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C6F33EB12;
	Tue,  2 Sep 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="nDBgrGDp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AF320A1C
	for <linux-api@vger.kernel.org>; Tue,  2 Sep 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830904; cv=none; b=FN2uxNPMyckUqe8BqkcJbHNyodp9FB8g7SgO4vSxBtyLOQVlz2g6C2zw7xrQYqeYqKeN+MIMmcRZYVO8R+dyGqZ5YTV6LXFT9WG5yLsDuMOtxDGb7tQx5vi3qNv6NXVfqSC9Pg2KkJauKE5tRcdR5gBU4zFNUEm/qbvghYeRxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830904; c=relaxed/simple;
	bh=dm/P2p84arvdIMkbFNyoYvTtXv3Uw8Y24JvTuG7Lt1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOJGLRb6LoV9rCAjmhQ2c3D9ovlBMIY7nS5p3OroDNIQaQDPCYmka7k3023ZEd54tQWuGXEe3mi+K8jMmwprTb8xkoCviEWp0aOQinvt7uq1kc1eiR0bbFABBFix/AwyyHGWpqU4bRvf8tMlT9iXn1Mvxk1GoMkh5q8mAV8tzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=nDBgrGDp; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 103623C2BEB46;
	Tue,  2 Sep 2025 09:34:56 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id rOzY7bckaoek; Tue,  2 Sep 2025 09:34:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id D951C3C32B0F0;
	Tue,  2 Sep 2025 09:34:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu D951C3C32B0F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1756830895;
	bh=vJNKfWOcL4pdGxZTuxgK7kjq97kF/FA4zDMW3baqb5A=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=nDBgrGDpu1yjpDrTu5n1P/i3aflZI2UgDBe5Njf11B1788/qhLA4q+TrRZ2VLuG+Y
	 9trPbtD3h8QCaeqPQCtDwHM5ZcejtHsYVl8QUk/JnLUkIdxp8OdwZS72g/dbg41p3w
	 M3qMUINZHfiXNKhepmBTssjFw1O6j335uyAvxOMpL+C5qWyDF99jtFkEaDaWT3x6H/
	 zcgbIKA+mQadVjClAF+fr2M9ttC4pAh9kzXQyIpfnjJbmmxD72e1hVYCWyc0IQQ0Je
	 X4KlXe2knHs2dNXpRsjl2rmu1GfyTRKDU66vcfQ7C+1gEH207Jlx6jhXCP4nC1yRL+
	 sSWrg4fRP6YMg==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id L6o5Xf6WwLoN; Tue,  2 Sep 2025 09:34:55 -0700 (PDT)
Received: from penguin.cs.ucla.edu (47-154-18-19.fdr01.snmn.ca.ip.frontiernet.net [47.154.18.19])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id AA4B53C2BEB46;
	Tue,  2 Sep 2025 09:34:55 -0700 (PDT)
Message-ID: <d88d7228-fabe-41d1-9a09-298fcb313647@cs.ucla.edu>
Date: Tue, 2 Sep 2025 09:34:55 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
To: Arjun Shankar <arjun@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 libc-alpha@sourceware.org, linux-api@vger.kernel.org
References: <2c5ae756-c624-4855-9afb-7b8e8ce91011@linaro.org>
 <828f6dfb-7402-45e1-a9ed-9e17b6356c5c@linaro.org>
 <2025-08-25.1756160579-pudgy-swank-chard-regalia-j3jdtD@cyphar.com>
 <5c3b9baf-76b4-40d7-87fb-9b8dd5afd1ee@cs.ucla.edu>
 <2025-08-26.1756212515-wealthy-molten-melody-nobody-a5HmWg@cyphar.com>
 <6432a34d-fba9-414e-ad38-d3354fa0d775@cs.ucla.edu>
 <2025-08-27.1756273344-decaf-ominous-thrift-twinge-h1gGBI@cyphar.com>
 <5c9fa556-da00-4b76-8a70-8e2d1dddd92d@cs.ucla.edu>
 <2025-08-27-perky-glossy-dam-spindle-kPpnnk@cyphar.com>
 <5cbd7011-9c2a-4a23-bbce-84c100877cdb@cs.ucla.edu>
 <2025-08-28-foreign-swampy-comments-arbor-nOkpXI@cyphar.com>
 <cbbc9639-0443-4bf8-bbd1-9d3fdcb2fd37@cs.ucla.edu>
 <CAG_osaYc21nR0M3O6UKs8zna6x_k9U4=Rt4B0mKHog=ZLSH1AQ@mail.gmail.com>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <CAG_osaYc21nR0M3O6UKs8zna6x_k9U4=Rt4B0mKHog=ZLSH1AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-01 19:41, Arjun Shankar wrote:
> While it is true that openat cannot be extended in this way, for
> openat2 (whether or not it eventually materializes in Linux) there
> already is the RFC patch series proposing CHECK_FIELDS that Aleksa
> referred to earlier.

Is this the RFC Aleksa proposed last October 
<https://lkml.org/lkml/2024/10/10/25>? If so, I don't exactly see a 
rousing endorsement there.

If not, where is the later RFC? I'd like to send the critical comments 
I've already sent on this thread. These comments have not been responded 
to adequately.


> Unless the kernel marks open_how as const

? The kernel doesn't mark anything as const. It merely copies in or 
copies out. And for openat2, it copies only one way.


> future if the kernel starts modifying open_how, glibc's openat2
> wrapper will no longer align with the kernel's behavior. At that
> point, glibc will either need to discard the const (which will cause
> any existing users of the wrapper to fail to recompile),

There are multiple easy ways out there. For example, glibc could 
document the argument as being pointer-to-const now, but warn that this 
may change to unrestricted pointer later, if the misguided change is 
made to the kernel. This would be similar to the already-existing 
warning in the proposed glibc patch, which warns that you can't assume 
sizeof (struct open_how) is a constant and so you can't expose it in 
library APIs. Of course people can ignore the documentation warnings but 
that's on them.

Better, though, would be to keep the API pointer-to-const. That's much 
cleaner. We can extend it later for a "give me the supported flags" 
flag, wwithout changing it the API away from pointer-to-const.

> Earlier on in this thread, Aleksa mentioned sched_setattr as
> establishing precedent for the kernel modifying non-const objects. It
> looks like glibc actually does provide a sched_setattr wrapper since
> 2.41.

Although it may be too late to change that misfeature, it's not too late 
to change this one. And even if it was a good idea for sched_setattr, 
that doesn't mean it's a good a good idea for openat2.


