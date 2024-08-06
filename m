Return-Path: <linux-api+bounces-2133-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51543948E4C
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 14:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF75A1F23134
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 12:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A351C232A;
	Tue,  6 Aug 2024 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="hqPX5xuL"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A8166F2F;
	Tue,  6 Aug 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945830; cv=none; b=fq7kOg+G/JS74FdM77zSHzzU9HZEtDZE3+yqHxuNMzgijXHCKXxyCU4KdrSX4LVpMuVij5sp9kcdkb0boHqTce4xoVlShJ5rNFQ6L+Wg3NGqpPw4Y5fUwGaC8zx+yo5vMe0LhNE82LbyGIHZP0RL3oERk6x/LSr2FVW5vWgrAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945830; c=relaxed/simple;
	bh=XRXafLpftx1tbKxHSErI9MCWKXph1KHyJZqpA0URBAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OolNvSmXcAlKdHc28mYfg/2QE3U7O1oOUFNQGJGvsvBppMBwx18o4Uark5PYFJX+liKPBZDgsNQOVJO3NHkTDVJGLvn+S69B4s32I826Ix6vNk4BEkKE4pD8LAR5B75uEPLC+hBfqQddDUZrZxwIvq/u6DlYcbjqhUkt0D94h04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=hqPX5xuL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1722945825;
	bh=TUApeyrXViRHjJ8RTPlVas4Td/RDYBhcdV8x/1z+BkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hqPX5xuL0Qux3mxKtPhI558jYrGFOmn3b6YIvND+qIAtlK1XmZ4kYcSu1oTMsmUCZ
	 NSAabITVcmoXnWTK0cJ1+NiAhk7ZildLoUbhip8cmDOUWXgsn+lg1ZXImoUxy9vcwP
	 X8u1wYq6guDP/73gxcQvHkCnxGcqB+/V3qPgTQk5cOk1ynctxPx9mWPlXMycktiWC7
	 q6jipj144CqjgC2VvJ2hf/F2DhgXarYcJmN0SnQDKtDAoSfNiUfDhRHlKIonXDH0Ic
	 ACeC4e7iO95Aw11p28Heu1QUzCTTn3juA0wcuIQgJpFvcsQEFdGxE0YcUEqe6EIftG
	 gOno6hu9Gj71w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WdX5W4tWXz4w2J;
	Tue,  6 Aug 2024 22:03:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Xu <jeffxu@google.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato
 <pedro.falcato@gmail.com>, kernel test robot <oliver.sang@intel.com>, Jeff
 Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck
 <groeck@chromium.org>, Jann Horn <jannh@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew
 Wilcox <willy@infradead.org>, Muhammad Usama Anjum
 <usama.anjum@collabora.com>, Stephen =?utf-8?Q?R=C3=B6ttger?=
 <sroettger@google.com>, Suren
 Baghdasaryan <surenb@google.com>, Amer Al Shanawany
 <amer.shanawany@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com,
 feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mseal] 8be7258aad:
 stress-ng.pagemove.page_remaps_per_sec -4.4% regression
In-Reply-To: <CAHk-=whQwJaS=jVWVvvvf0R=45EGMb0itmhhSpa7_xWJXQY71Q@mail.gmail.com>
References: <202408041602.caa0372-oliver.sang@intel.com>
 <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com>
 <87o766iehy.fsf@mail.lhotse>
 <CAHk-=whQwJaS=jVWVvvvf0R=45EGMb0itmhhSpa7_xWJXQY71Q@mail.gmail.com>
Date: Tue, 06 Aug 2024 22:03:42 +1000
Message-ID: <87bk25j1sx.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, 5 Aug 2024 at 19:14, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Needs a slight tweak to compile, vvar_close() needs to return void.
>
> Ack, shows just how untested it was.
>
>> And should probably be renamed vdso_close().
>
> .. and that was due to the initial confusion that I then fixed, but
> didn't fix the naming.

Ack.

> So yes, those fixes look ObviouslyCorrect(tm).

Needs another slight tweak to work correctly. Diff below.

With that our sigreturn_vdso selftest passes, and the CRIU vdso tests
pass also. So LGTM.

I'm not sure of the urgency on this, do you want to apply it directly?
If so feel free to add my tested-by/sob etc.

Or should I turn it into a series and post it?

cheers


diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 431b46976db8..ed5ac4af4d83 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -85,6 +85,15 @@ static void vdso_close(const struct vm_special_mapping *sm,
                        struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
+
+	/*
+	 * close() is called for munmap() but also for mremap(). In the mremap()
+	 * case the vdso pointer has already been updated by the mremap() hook
+	 * above, so it must not be set to NULL here. 
+	 */
+	if (vma->vm_start != (unsigned long)mm->context.vdso)
+		return;
+
 	mm->context.vdso = NULL;
 }
 

