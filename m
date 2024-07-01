Return-Path: <linux-api+bounces-1810-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612B391DE62
	for <lists+linux-api@lfdr.de>; Mon,  1 Jul 2024 13:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934771C20D4C
	for <lists+linux-api@lfdr.de>; Mon,  1 Jul 2024 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E71F14B06C;
	Mon,  1 Jul 2024 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O6qhCzL1"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624314A601;
	Mon,  1 Jul 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834791; cv=none; b=XY+6BQ3gjoimuvhZA9fPJ/enOS9u0EUmNcP8Ou5G3qSfmJ+JCWG2zh3tt9FBDdkBG12H48irmCdYg+FhyylQjb9uunoFijT498DcQJri3qJm48s+JzB2mNmZ/RoJQIiduskv490dTMlFSjc3qM0xAgPL71B0Fs/6Cv+XlfunKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834791; c=relaxed/simple;
	bh=vKDM44VET0ISDBwcNtPUEEiERcMPn9O7mLC4TjHOZ80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4l5G4dGfYOTZ9u1dmQmgeeIV5GSjx90yBqrVDGGbt+aw1WU3YeWu3ChpOHNEGgxYA+lKxJIczVRSZ0lkYoabVMzNTRO+mfVmg1z8pnsOPjYFcIUv4eLaYOCkGxwvbDwsxqvNivF3lR5muc4YgMhkmSHT3unI6fvCDKCA8A3+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=O6qhCzL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B531C2BD10;
	Mon,  1 Jul 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O6qhCzL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1719834787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BdJk45yqWfAF6GzrWiLUT4OERI93TgE+sNwH9kDnoUI=;
	b=O6qhCzL1UqaP9OmQMiGvaqfgQIkuqdGJxVyuwGFZxSyXxf70lZBi6WuLHkNATF4f9u2r5o
	Vl8I/mObuqeWf/v/9TdNNLvaJGZlf1ikZftxdYT4T4BbsDh2XDXng0jV1Y7NDIAsmOd3aq
	R1SKNw65Tsg+asToLqMmCu4u4yP9Tyg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 67037b82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jul 2024 11:53:07 +0000 (UTC)
Date: Mon, 1 Jul 2024 13:53:04 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v18 2/5] random: add vgetrandom_alloc() syscall
Message-ID: <ZoKYoBp_bSRP_fqn@zx2c4.com>
References: <20240620005339.1273434-1-Jason@zx2c4.com>
 <20240620005339.1273434-3-Jason@zx2c4.com>
 <20240620.020423-puny.wheat.mobile.arm-1wWnJHwWYyAl@cyphar.com>
 <ZnQeCRjgNXEAQjEo@zx2c4.com>
 <87v81txjb7.ffs@tglx>
 <Zn7D_YBC2SXTa_jX@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zn7D_YBC2SXTa_jX@zx2c4.com>

On Fri, Jun 28, 2024 at 04:09:01PM +0200, Jason A. Donenfeld wrote:
> fine. Also I used u32 there for the two smaller arguments, but maybe
> that's silly and we should go straight to u64?

Judging by `struct clone_args`, it looks like I've got to use
__aligned_u64 for every argument:

    struct clone_args {
        __aligned_u64 flags;
        __aligned_u64 pidfd;
        __aligned_u64 child_tid;
        __aligned_u64 parent_tid;
        __aligned_u64 exit_signal;
        __aligned_u64 stack;
        __aligned_u64 stack_size;
        __aligned_u64 tls;
        __aligned_u64 set_tid;
        __aligned_u64 set_tid_size;
        __aligned_u64 cgroup;
    };
    #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
    #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
    #define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
    
So okay, I'll do that, and will have an ARGS_SIZE_VER0 macro too.

Jason

