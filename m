Return-Path: <linux-api+bounces-2668-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C179BC051
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2024 22:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E161C21EEC
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2024 21:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620661A727F;
	Mon,  4 Nov 2024 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RS6FoNd5"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B41F1925B0;
	Mon,  4 Nov 2024 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757006; cv=none; b=kY3/wh20JNubWfGbvYiqHAKi5LMcBB84LwOo7TnkINynrmixS45LC5uKGwa04nk+iHavTdz7pCkF6RNYhZ3aey/hTMv/7qSFYmjmQbeZt8vngpro+ifviNnV/2rbJLM4SmWeC+vJjxB+ygRyd6XJoEBEHQJZHn+BgyrpnyJYQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757006; c=relaxed/simple;
	bh=iaKl3Fueg5Xx9NXIec9ThErAtunEnnNu99nhfDYI5DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3yGxMc/iLFZQGbCOdKrypchOkCCl+yPGB5Y6EkbZfhNheEsuEqDh1FTNM+qXiXM3sJzadJcTXceolRT63GssQKutzk0HFmpz9DbwfmzRDCbn2rS3yk42Jr0fZMsDbgANMZ21GAwdRSQ1T7wAw7vOGhrJqX7kGj9HwzfR/nIFsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RS6FoNd5; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qWby2EMjdr3KdnGYTyIad9ahs4Cb/fmVAxGGKYIWJqE=; b=RS6FoNd5BcI/p6NO86dWLpOESF
	Urg1Y0y5r2tAS1kvwLBIxSyAI97qCUFdQ9GZKIulKI9wCgsS1GcCPcduYcvuIfG+ntAALDf97Hl3/
	m3vpMbEojJQKdUZwSqbnyW73g89BUJsp+Wrm5UhuKtXaCpDfVT+ioH7zuKDJJZsZkQAQS1tXKXfaI
	SiAhBZc28oEqfvrBJKF3PTUT7IpbHsMAh6ndUq/JcMyLlDGA/eZlD2A1+X2r3djrhadnffVxG9Pe/
	rCtgjidva0o1LCrthVKHPEno9vfVUmKGfyJyB6vtMXgmDX0Ghokt3lvKzRJ1OdvElDV1VS6h34WGN
	xeNwK/AQ==;
Received: from [177.172.124.78] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t84xB-001qpI-1j; Mon, 04 Nov 2024 22:49:41 +0100
Message-ID: <33952c0e-737d-4170-9b25-d5818e9fc05b@igalia.com>
Date: Mon, 4 Nov 2024 18:49:34 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] futex: Create set_robust_list2
To: Florian Weimer <fweimer@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
 sonicadvance1@gmail.com, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, linux-api@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>
References: <20241101162147.284993-1-andrealmeid@igalia.com>
 <87ldy170x9.fsf@oldenburg.str.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <87ldy170x9.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Florian,

Em 02/11/2024 18:58, Florian Weimer escreveu:
> * André Almeida:
> 
>> 1) x86 apps can have 32bit pointers robust lists. For a x86-64 kernel
>>     this is not a problem, because of the compat entry point. But there's
>>     no such compat entry point for AArch64, so the kernel would do the
>>     pointer arithmetic wrongly. Is also unviable to userspace to keep
>>     track every addition/removal to the robust list and keep a 64bit
>>     version of it somewhere else to feed the kernel. Thus, the new
>>     interface has an option of telling the kernel if the list is filled
>>     with 32bit or 64bit pointers.
> 
> The size is typically different for 32-bit and 64-bit mode (12 vs 24
> bytes).  Why isn't this enough to disambiguate?
> 

Right, so the idea would be to use `size_t len` from the syscall 
arguments for that?

>> 2) Apps can set just one robust list (in theory, x86-64 can set two if
>>     they also use the compat entry point). That means that when a x86 app
>>     asks FEX-Emu to call set_robust_list(), FEX have two options: to
>>     overwrite their own robust list pointer and make the app robust, or
>>     to ignore the app robust list and keep the emulator robust. The new
>>     interface allows for multiple robust lists per application, solving
>>     this.
> 
> Can't you avoid mixing emulated and general userspace code on the same
> thread?  On emulator threads, you have full control over the TCB.
> 

FEX can't avoid that because it doesn't do a full system emulation, it 
just does instructions translation. FEX doesn't have full control over 
the TCB, that's still all glibc, or whatever other dynamic linker is used.


