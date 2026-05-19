Return-Path: <linux-api+bounces-6357-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OyDCkCUDGp1jAUAu9opvQ
	(envelope-from <linux-api+bounces-6357-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 18:48:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC365829A1
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 18:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4A6E3029EA3
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E548C8DC;
	Tue, 19 May 2026 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCDj36xB"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04D730B51D
	for <linux-api@vger.kernel.org>; Tue, 19 May 2026 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209277; cv=pass; b=UImkvPknEiEZVnsyaghVgAF7mv5nzEwD0CVH02llrkDJjxdrap7xgA2s0vVg1F7lyrJxnEqW0VzD0NS9e+i6R/tB+pxyl0CKiA1PsrGFH3blhrLtxivpnEZFHSyEHwiI0N+zDZ/wNV66mOvVETcynRLAImhDzVwyR3yjHJAN+ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209277; c=relaxed/simple;
	bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJyiLPC7xbGlC40k4ca29zz3awDSYyq4dK8XgzHKtI0zNOCfqWePmHWVRHZ6/wZbfMPbhFNHpkzFiZYArORMmZl/uaY0BNjyKso3q8yr1btyTbE7xYJyPFzqJOz2zvWkwH4GdOLjFqztvijoxxgjITH13dYFLU1daGZYqpJEMtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCDj36xB; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c8d0945b3so97c88.0
        for <linux-api@vger.kernel.org>; Tue, 19 May 2026 09:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779209275; cv=none;
        d=google.com; s=arc-20240605;
        b=LvF41iCoCkZ2UHtsjEzIgzULxPkiA1+EjM0W5M8vKZR/APW9EZBwN4xuI1bh+en7+j
         LmkEkBVCRhKrZkmhTmyagLAL/+L6v1XOGUVAOgoxrIH+AQwgoDeWaI2bYGwAakssNdrP
         lwS+GzEorr3NAT5aH+JF8RggMsEg6m3KHgrrCDl4K6rkhOLprNslo7ki4WX4rye74MQ2
         2Vaot9gyrzboeBi58a1Ffx8++pZ6kxD53s3Og0WiU3WN1c67Pv4DrdEcxrCW8oXFbyP4
         /lmpl6Z5z60u6MTgial9dqg/Wdl6oO9IAUqSEzPekuxDIsDiZM228xh2xFtrWr0qxJbn
         xC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
        fh=7xslzfr2T5yUQYPBBmKHifQkfiHmMNGbCQDCvz15h2M=;
        b=XuN9o0x6JFA8a6sNjeai2NQq5rYxp7vjbKW08no+rpCmrKKRZeMRrg3bSKoVVCmQQE
         xXQMBzHFcfR0W2dtTDqm9vhYPnVjiOJvsCnG1cpZNRunXhF5c15WZPITcxwfwtG9rKrv
         CgeD6+GV1M2eM296r23HGs5yF3I63ocHWkoMAv75RI6+24D9YRuOsAm0mcIOGt78V1/f
         mhCmoCT+IA9tVg85ZtG6bToSHTEyZtqPv0UjzMMSYQ6y6YDWqK4CDRMK4jphr9FewJ8W
         y8QZnTp8f0JX9Q5aOhY14wxQywqfPV3CmujPKhoX3y7vrp9D+VSGSXiibdUFkzUsIpZz
         kDNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779209275; x=1779814075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
        b=qCDj36xB+gWsx5I++4gl23aTy/IsknfkUlDdViRQo5wucJqQ8XdghhD+kLpe7INyJX
         D5hDNw4zhXmqyvnDQ+SLTsfjy3d+aAzPtHK4Hf/yZvzw4vcTdOfCgbx45BElKmR12hfX
         pu5c2HaqaT73C2IpAxqMFMcZNTBN0dPwrTcBUBQ9H3m6bZt6mx/YJhlrLDFNw5Cvbfji
         jvAUMXhEKAap1D9lrGHZsUO74k7gq02nBUlPXXnPBlgSayaJKDgXw3EWOzWfApAElNs6
         BfzZRPCYgAd0MgV4u2ao7+QnmxOz2O+5xUIt6DXaGaTbjbG45iFgS0OcpDl/H5i84vQ9
         f0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779209275; x=1779814075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
        b=XwcxAkXIvpoUnigEhhrYBh0wcJ+OjDq7WmVqhDedKtZa3QpkV5Nb4xHZJ/va4H8vZG
         cLGrZX1dppCr5yt4Q0eFV+VUTvEfCTnkRuEUBemRPBu6mbAK1vq88MWIx7C3SEx7sD5a
         1LqjmU6ICGyVEIkBYw3bX9qiHMGZ/F0aus33VfKCVfuAz1Klwa2IVRA+dz3qW6xTcHEg
         89wm4qn0cd6XRILloe+gi1M0VhV6sPOve9IAoXXi8oYZGv2gpRgs1/ev2ufrxCZ312tl
         ZARHa2H3TlYR4DYAWvC/3DJv4ZJHFYX+GeqAkeg6HHpmv4k+RSg2jNXJ6Hw1MsXwTtCO
         dbGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nE1ybxQLoo6tfdnAiizRCKG108/hcKrQ1B2+ig8JYigqXPi0cOjVyzV1RxNBGxaOQXUt2xIzA3UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzogHFX7XTtkJSt/dbfT++PnHIS+q1qacCpHxob040F7RW1QWnY
	+OEJ0jlIEVQoWIOIRakIHcqiRpj+XamHh70kc8eLiIQguNXlS6PZ4PrhA3MBI2J7j0AuSbOOIml
	iqZm5WpPVl2me8xHKjBcD7LK4wB8JtXZKFgGNn/sV
X-Gm-Gg: Acq92OGeu+GcxxWl2u4ZoYX5eIxot5fjx6/OrjO8gIw+ADIqODFpm/UkRtzx3EYgjOy
	UAd5ZPNYphUsKcNMW9eUWKUKhyQJXOGyw6aCRwvnju47/zq5zudzAzukHcyMeEluEo8W8P6mExH
	qMVUazz8WuQvVmVVimZKCL2bU+8tHDGB0jr1qva7hmOb2IFqzjKm4J8y74os80l0/OWwKvhS3jX
	hC5rylVdZ/8VZDBczc1kuMZmL6INUUSWukf2mj97tt03b/lFvbw9V/yt7HZ6IL9lW0YCnHR63KI
	fD97fuucWB5xinzeTypKTmk/kiEoBQc0ddZJvsg+awbWweDI
X-Received: by 2002:a05:7022:41a3:b0:12c:2ed4:6314 with SMTP id
 a92af1059eb24-13557dcef85mr326451c88.1.1779209273823; Tue, 19 May 2026
 09:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F78521DA-08DC-424E-BBE1-231BC900CEE0@gmail.com>
In-Reply-To: <F78521DA-08DC-424E-BBE1-231BC900CEE0@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 18:47:15 +0200
X-Gm-Features: AVHnY4LvG4Du5d39_T67NOwKnozMptM-y7xFRUTkKn7VXkYMQfWRo6DTkXiA7Lg
Message-ID: <CAG48ez0KsuR5z4RDgxWPUoS8e_MJzF74RgFDJayohG48A_N0PQ@mail.gmail.com>
Subject: Re: [RFC] TID v2.0: kernel module for cache-line zeroization against
 Flush+Reload (CLFLUSHOPT + LFENCE + REP STOSQ)
To: Ahmed Hassan <ahmaaaaadbntaaaaa@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel-hardening@lists.openwall.com, 
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-6357-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BCC365829A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 11:47=E2=80=AFPM Ahmed Hassan
<ahmaaaaadbntaaaaa@gmail.com> wrote:
>
> Hi kernel developers,
>
> I am sharing TID (The Instant Destroyer) v2.0, a Linux kernel module
> written in C that addresses a specific gap in existing security
> libraries: none of them (libsodium, OpenSSL, glibc memzero_explicit)
> flush CPU cache lines after memory zeroization.
>
>
> =3D=3D Problem =3D=3D
>
> Standard zeroization functions (explicit_bzero, sodium_memzero,
> OPENSSL_cleanse) prevent the compiler from eliding the wipe, but do
> not evict CPU cache lines (L1/L2/L3). This leaves residual key
> material measurable via Flush+Reload (Yarom & Falkner, 2014) after
> data use ends.

The thing you're talking about isn't really related to the
Flush+Reload side channel attack, right? You're just talking about
flushing cache lines.

In what threat model would this be an issue? Normally, the goal of
memory zeroing is to ensure that sensitive data is wiped before an
attacker has a chance to physically pull out the RAM from a machine
and plug it into another device that can reveal RAM contents, or
before an attacker gains physical control of a locked device and can
connect malicious peripherals to it, or such.

So for this to be an actual security problem, the device would have to
keep running in a sufficiently high power state that data caches are
not discarded, and at the same time not perform enough memory accesses
to cause this memory to be discarded...

Assuming that this is an actual problem, why are you using a kernel
module for this? At least on x86, CLFLUSH is unprivileged, so crypto
libraries should be able to just use that directly. (There is the
caveat of what happens when the kernel migrates pages or kills a
process, but that's a larger problem.)

