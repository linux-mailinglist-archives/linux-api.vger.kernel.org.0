Return-Path: <linux-api+bounces-1752-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD8490C096
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 02:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A318E1C21927
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 00:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3606AC0;
	Tue, 18 Jun 2024 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Hj+bkOdt"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4BB5C99;
	Tue, 18 Jun 2024 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671133; cv=none; b=lCO9xPFW22pDdKgnqyI6MM3dSQuUb+d+Tgsd5jj5x3X+Ro5JPlt6uuAzm5MHV4a0rjYv78xJVRi96ajdTJNyluKWSURxWWz1z9Ox2QEisucKcamwWpEmeRGuScHcZPEVNiFB0R2EP7diQ/zPONA28O5IlPcSiRIRZb5em8HT/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671133; c=relaxed/simple;
	bh=EPu8yNRPgkjN30FqQ0/xKvZOyIHNqxkwG+P/BwDOee8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpgTCQtV3tDeUa3flrM1QCJkwQqOkCUI2ruOaZzVO3E8ricoWcpxSnX/h80m4THoGxboEoUePApa+U7DXAxauhib6oT0wX84sG2i2GTlwwLcP0Lwuj3bp6Fz6hXYFWxuO4S5cxKr2Lxd8ugMPn87KAwBNvbTXfIJqvbYdr00nU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Hj+bkOdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93CFC2BD10;
	Tue, 18 Jun 2024 00:38:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Hj+bkOdt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718671129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zpgIOfekLV3UH6+yks33ApiI6XLkbCD6hrIOKNwA7s=;
	b=Hj+bkOdtifI+V5WIsaCqAOPCq4Af58HRHxZve02QIVYgL2s43z6kj8zmjY2qYbu9qt3zoJ
	KD4yVFyf4PSUbGTnTQsYjPXjrgDZ1hg1z1SS8cgw+SemNjTYFdGLiWvXsbEPruhnlHQK5V
	Vkn8ji7yhjHauaIJx4Fpu0K0yayjAgA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 086ed137 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Jun 2024 00:38:49 +0000 (UTC)
Date: Tue, 18 Jun 2024 02:38:47 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v17 4/5] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <ZnDXFywDvqRitRgL@zx2c4.com>
References: <20240614190646.2081057-1-Jason@zx2c4.com>
 <20240614190646.2081057-5-Jason@zx2c4.com>
 <CALCETrVQtQO87U3SEgQyHfkNKsrcS8PjeZrsy2MPAU7gQY70XA@mail.gmail.com>
 <ZnDQ-HQH8NlmCcIr@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnDQ-HQH8NlmCcIr@zx2c4.com>

On Tue, Jun 18, 2024 at 02:12:40AM +0200, Jason A. Donenfeld wrote:
> Hi Andy,
> 
> On Mon, Jun 17, 2024 at 05:06:22PM -0700, Andy Lutomirski wrote:
> > On Fri, Jun 14, 2024 at 12:08 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > Provide a generic C vDSO getrandom() implementation, which operates on
> > > an opaque state returned by vgetrandom_alloc() and produces random bytes
> > > the same way as getrandom(). This has a the API signature:
> > >
> > >   ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state);
> > 
> > Last time around, I mentioned some potential issues with this function
> > signature, and I didn't see any answer.  My specific objection was to
> > the fact that the caller passes in a pointer but not a length, and
> > this potentially makes reasoning about memory safety awkward,
> > especially if anything like CRIU is involved.
> 
> Oh, I understood this backwards last time - I thought you were
> criticizing the size_t len argument, which didn't make any sense.
> 
> Re-reading now, what you're suggesting is that I add an additional
> argument called `size_t opaque_len`, and then the implementation does
> something like:
> 
>     if (opaque_len != sizeof(struct vgetrandom_state))
>     	goto fallback_syscall;
> 
> With the reasoning that falling back to syscall is better than returning
> -EINVAL, because that could happen in a natural way due to CRIU. In
> contrast, your objection to opaque_state not being aligned falling back
> to the syscall was that it should never happen ever, so -EFAULT is more
> fitting.
> 
> Is that correct?
> 
> If I've gotten you right this time, I'll add that argument as described.
> Seems straight forward to do. It's a bit annoying from a libc
> perspective, as the length has to be stored, but that's not impossible.

So, that looks like:

diff --git a/arch/x86/entry/vdso/vgetrandom.c b/arch/x86/entry/vdso/vgetrandom.c
index 6045ded5da90..794137fba649 100644
--- a/arch/x86/entry/vdso/vgetrandom.c
+++ b/arch/x86/entry/vdso/vgetrandom.c
@@ -6,12 +6,12 @@

 #include "../../../../lib/vdso/getrandom.c"

-ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *state);
+ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len);

-ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *state)
+ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
 {
-	return __cvdso_getrandom(buffer, len, flags, state);
+	return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
 }

-ssize_t getrandom(void *, size_t, unsigned int, void *)
+ssize_t getrandom(void *, size_t, unsigned int, void *, size_t)
 	__attribute__((weak, alias("__vdso_getrandom")));
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 51251190a47e..4d89e34ff17d 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -40,6 +40,7 @@ static void memcpy_and_zero_src(void *dst, void *src, size_t len)
  * @len:		Size of @buffer in bytes.
  * @flags:		Zero or more GRND_* flags.
  * @opaque_state:	Pointer to an opaque state area.
+ * @opaque_len:		Length of opaque state area, as returned by vgetrandom_alloc().
  *
  * This implements a "fast key erasure" RNG using ChaCha20, in the same way that the kernel's
  * getrandom() syscall does. It periodically reseeds its key from the kernel's RNG, at the same
@@ -55,7 +56,7 @@ static void memcpy_and_zero_src(void *dst, void *src, size_t len)
  */
 static __always_inline ssize_t
 __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
-		       unsigned int flags, void *opaque_state)
+		       unsigned int flags, void *opaque_state, size_t opaque_len)
 {
 	ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
 	struct vgetrandom_state *state = opaque_state;
@@ -69,6 +70,10 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 	if (unlikely(((unsigned long)opaque_state & ~PAGE_MASK) + sizeof(*state) > PAGE_SIZE))
 		return -EFAULT;

+	/* If the caller passes the wrong size, which might happen due to CRIU, fallback. */
+	if (unlikely(opaque_len != sizeof(*state)))
+		goto fallback_syscall;
+
 	/*
 	 * If the kernel's RNG is not yet ready, then it's not possible to provide random bytes from
 	 * userspace, because A) the various @flags require this to block, or not, depending on
@@ -222,7 +227,7 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 }

 static __always_inline ssize_t
-__cvdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state)
+__cvdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
 {
-	return __cvdso_getrandom_data(__arch_get_vdso_rng_data(), buffer, len, flags, opaque_state);
+	return __cvdso_getrandom_data(__arch_get_vdso_rng_data(), buffer, len, flags, opaque_state, opaque_len);
 }

