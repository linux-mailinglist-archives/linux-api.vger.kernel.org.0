Return-Path: <linux-api+bounces-2246-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9588C95E409
	for <lists+linux-api@lfdr.de>; Sun, 25 Aug 2024 16:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48AC1C20912
	for <lists+linux-api@lfdr.de>; Sun, 25 Aug 2024 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C1861FFC;
	Sun, 25 Aug 2024 14:56:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.ouvaton.coop (smtp.ouvaton.coop [194.36.166.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AA1D69E;
	Sun, 25 Aug 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.36.166.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724597818; cv=none; b=mCK65pZQDxdm64OYFaiSdUZRA92L38b1XYBtoQMI0q03i8TiJsqorVnbDmiZ9dGBfer7R/Npno99w+WI2RsqhC40iYMJBwbzTjj3LRt2/TSRFBPZdeH3RMZTuG7oOl/Yz6FhmCa8mIxIGcF8VVO8QNN3KfpNjjiv7nQGaga/1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724597818; c=relaxed/simple;
	bh=pje8LvzpwZxpfyPmKKZhrdQ4pVRqF60UwIBYRCsY1Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7i3foMqu0xmS+DoGjwggKub2hYKZHSBbmRGRa9atNJoy/SpcgL1usHYJRdzCg0va1K6QL75ZqyXKftATtmv/Rl1egrqWJZ7XvDw7HpK5uJE/ITUBqAgxJrfxesNLw6JN4cKJFAY0NzieeE1oAuq7XGQm6WFFR3SIeZ/b16YMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=droneaud.fr; spf=pass smtp.mailfrom=droneaud.fr; arc=none smtp.client-ip=194.36.166.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=droneaud.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=droneaud.fr
Received: from ouvaton.coop (82-65-99-74.subs.proxad.net [82.65.99.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ouvalternc.octopuce.fr (Postfix) with ESMTPSA id A47952F5EC;
	Sun, 25 Aug 2024 16:48:12 +0200 (CEST)
From: Yann Droneaud <yann@droneaud.fr>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Yann Droneaud <yann@droneaud.fr>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org,
	Theodore Ts'o  <tytso@mit.edu>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: [PATCH] random: vDSO getrandom() must reject invalid flag
Date: Sun, 25 Aug 2024 16:47:50 +0200
Message-ID: <20240825144758.325298-1-yann@droneaud.fr>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240712014009.281406-3-Jason@zx2c4.com>
References: <20240712014009.281406-3-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like getrandom() syscall, vDSO getrandom() must not let
unknown flags unnoticed [1].

It could be possible to return -EINVAL from vDSO, but
in the likely case a new flag is added to getrandom()
syscall in the future, it would be nicer to get the
behavior from the syscall, instead of an error until
the vDSO is extended to support the new flag.

[1] Designing the API: Planning for Extension
    https://docs.kernel.org/process/adding-syscalls.html#designing-the-api-planning-for-extension

Signed-off-by: Yann Droneaud <yann@droneaud.fr>
---
 lib/vdso/getrandom.c | 4 ++++
 1 file changed, 4 insertions(+)

Hi Jason,

Please indulge me as I'm a bit late to add some junk to the conversation[2].

[2] Re: [RFC PATCH 0/4] random: a simple vDSO mechanism for reseeding userspace CSPRNGs
    https://lore.kernel.org/all/CAHmME9oXB8=jUz98tv6k1xS+ELaRmgartoT6go_1axhH1L-HJg@mail.gmail.com/

Bye.

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index b230f0b10832..be9db42c8309 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -89,6 +89,10 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 	if (unlikely(opaque_len != sizeof(*state)))
 		goto fallback_syscall;
 
+	/* Unexpected flags are to be handled by the kernel */
+	if (unlikely(flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE)))
+		goto fallback_syscall;
+
 	/*
 	 * If the kernel's RNG is not yet ready, then it's not possible to provide random bytes from
 	 * userspace, because A) the various @flags require this to block, or not, depending on
-- 
2.46.0


