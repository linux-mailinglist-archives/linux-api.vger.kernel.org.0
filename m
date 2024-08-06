Return-Path: <linux-api+bounces-2128-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D55794875C
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 04:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B07B23846
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 02:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72F48F6D;
	Tue,  6 Aug 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="L60l+Kun"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618DC184D;
	Tue,  6 Aug 2024 02:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910495; cv=none; b=AGd4jGPVGbi91P+Y1ab2GFK3TVLbUSSA/8Bm5d3bqMIjwmudDCIJcgu3/CLmGuGRkstPCPCx8Yu1LZL67WyBE8vK8k5r5B4GVrc1zj2zshR6/U3Sknnv2AQVVKK0wYrErI0SDJ+DWA6pGImOVLoJXMo9UmEzC89t1CoQMcexHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910495; c=relaxed/simple;
	bh=8kLxkPIel3Deiud36xE9FFx6blTR2NSiAbZzC663N40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bPrV5B4JiALFkJh83B4I1Biyexd9d8vLvtsFZSPo3Uj4l/QF/NoOGMgf6b62IoK911z9D8oAwSRNpS1XCaaOZZiHcwCJhdjBd/Bo0Nvb1jMyRThG5HRDg895b9b8wPZznvKxetl5ntbhMNzWZc93TKkvLkYz3Y5phKUlTYnIbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=L60l+Kun; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1722910490;
	bh=2ONMfWmaTnFHnMkqwpfCM8ovP5jYUNj89q2YCaQS+4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L60l+KunMuY/NEqPl82SknN6Qv6nRfykeN0bWYix/i48CyRDqMgG281OIgNZ47K/9
	 WSzHA5+cDiLjY3nHWdSeftjBlm43qcEPy6naRRKOs5jgHV9Dc+XreOGpVIpGX4VdcJ
	 isUMCHRo7L70OcBSck5FNUi9n6uMTVagKJOAiTh7XpM4hSwzraiMKmrw0lWsUcx3AK
	 CDlgIpP0YQRyPJbtA22FAIYFr8gBZfVTJslGIUN7NRKlgExi94uuwWiz0nqaE3dEcb
	 r8wLvpHhzwFAmK3po3ANtOmcC8PfJO0H32b1kfXY+sfehI5z4ErzrbABaiVKpUIa70
	 UYRspwF+38w/Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WdH221XJ4z4w2L;
	Tue,  6 Aug 2024 12:14:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Xu
 <jeffxu@google.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, kernel test robot
 <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook
 <keescook@chromium.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave
 Hansen <dave.hansen@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, Jann
 Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Jorge Lucangeli
 Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>, Stephen =?utf-8?Q?R?=
 =?utf-8?Q?=C3=B6ttger?=
 <sroettger@google.com>, Suren Baghdasaryan <surenb@google.com>, Amer Al
 Shanawany <amer.shanawany@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com,
 feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mseal] 8be7258aad:
 stress-ng.pagemove.page_remaps_per_sec -4.4% regression
In-Reply-To: <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com>
References: <202408041602.caa0372-oliver.sang@intel.com>
 <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com>
Date: Tue, 06 Aug 2024 12:14:49 +1000
Message-ID: <87o766iehy.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, 5 Aug 2024 at 11:55, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> So please consider this a "maybe something like this" patch, but that
>> 'arch_unmap()' really is pretty nasty
>
> Actually, the whole powerpc vdso code confused me. It's not the vvar
> thing that wants this close thing, it's the other ones that have the
> remap thing.
>
> .. and there were two of those error cases that needed to reset the
> vdso pointer.
>
> That all shows just how carefully I was reading this code.
>
> New version - still untested, but now I've read through it one more
> time - attached.

Needs a slight tweak to compile, vvar_close() needs to return void. And
should probably be renamed vdso_close(). Diff below if anyone else wants
to test it.

I'm testing it now, but it should do what we need.

cheers


diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 6fa041a6690a..431b46976db8 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -81,8 +81,8 @@ static int vdso64_mremap(const struct vm_special_mapping *sm, struct vm_area_str
 	return vdso_mremap(sm, new_vma, &vdso64_end - &vdso64_start);
 }
 
-static int vvar_close(const struct vm_special_mapping *sm,
-		      struct vm_area_struct *vma)
+static void vdso_close(const struct vm_special_mapping *sm,
+                       struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	mm->context.vdso = NULL;
@@ -99,13 +99,13 @@ static struct vm_special_mapping vvar_spec __ro_after_init = {
 static struct vm_special_mapping vdso32_spec __ro_after_init = {
 	.name = "[vdso]",
 	.mremap = vdso32_mremap,
-	.close = vvar_close,
+	.close = vdso_close,
 };
 
 static struct vm_special_mapping vdso64_spec __ro_after_init = {
 	.name = "[vdso]",
 	.mremap = vdso64_mremap,
-	.close = vvar_close,
+	.close = vdso_close,
 };
 
 #ifdef CONFIG_TIME_NS

