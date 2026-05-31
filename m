Return-Path: <linux-api+bounces-6475-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBnAGm6mHGpIRAkAu9opvQ
	(envelope-from <linux-api+bounces-6475-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 23:21:50 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEB3618029
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 23:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A00F1300D9CF
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEA133A708;
	Sun, 31 May 2026 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7aI7eRe"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8620468E
	for <linux-api@vger.kernel.org>; Sun, 31 May 2026 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780262505; cv=pass; b=EnusNMZPGbSRiriTkb5OGNdsuYqx86fqjbhZgCQ5SVphDfSkSJ4qZRe181t/3kAyk32+Qh/A4JRgwxoFTr+FQDc3dIeFfOeVSBx2qvS3XYy+LqHrpYbM/xAlAFB9l1LvF8tZ8U6XdPO6SaNOgLbTfT90mI7P40BVX53gDctPYFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780262505; c=relaxed/simple;
	bh=HK+FQZK/X2670pSoGvJT+eXxMm/YbYUTBbsmMo4Pt1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+286nYQCZn0I0xUImLC534e1M38mTds7uKIyflGxP8atP4e8aJsMConasSjM1R2XSAFZ/izU3mFYMMmhrJZZ51u4g1dSmvfFGxgQJaCHm/jIzcxH/onRu3nGcqoheI1poGD3YYqa/pZnWEBI39Tjdri+pztUOKGah02/1LO69k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7aI7eRe; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec449d0af2so75944566b.2
        for <linux-api@vger.kernel.org>; Sun, 31 May 2026 14:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780262502; cv=none;
        d=google.com; s=arc-20240605;
        b=RIQBVbtC/wJPGI5IcyEGCCun8W7b5Xm5dC+JgYWTvo1C1fLQq/IRGNQi6FOaJin/3o
         vm65tMMlawIREd8wuvRoqiNQtZnaY5F25rn/BSIYoX4+CYwUoOai4bA4Ytwo4My9nGez
         y4uoxVeQcobRp/NfxIfKtKz1Csk/TMdsSeW8IHPkPgdA4idCEL6F8ytVozpRogBei9RL
         bD+SUlf4LHNwCT15guPUNwrGUVxB5C89PIdKEn8Qn+AcQDXUubFuG/ggJQSg0zFxmIiZ
         3KYYSlYYduXokspLuTFhZany0l0+u9flHZ7TaVZ3SdaVntdg9kVMntY+54ZW+v21L0UT
         UL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HK+FQZK/X2670pSoGvJT+eXxMm/YbYUTBbsmMo4Pt1U=;
        fh=9IvPEGmQuqkIW3DTK5/G/WXi8R0SrVBzuklffgySoAg=;
        b=hwtUC+EbvQMLt1HQA/7On5dPqUY7V0TttneRNRjqZZL5rqD64Oz8pdG0N07JURxUIp
         KIjRgKHPNOWHUOdorDanCMZJ2Uu1F7UhsK6CG8soIZimoDo27mMkKeUX2VaNOczfDDIP
         uYFDbmIjyA2XGvlnSfG4GmzfQFrlunoiE5+anXVj38ZWix3W7MTGGT7lzDkZdAGq1+5g
         SH1JB1c5RGzRh0SJH2omLpC3bHututtBChRN8BzEEOs630TofSobAPKHeWfAEff4EYYh
         o22AfvujGKGhrid54KBTO1Jf80jKicc/DV8kJ2E1YAvJEyJBxZmjcbCesW2PIjkFc4+l
         59dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780262502; x=1780867302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK+FQZK/X2670pSoGvJT+eXxMm/YbYUTBbsmMo4Pt1U=;
        b=c7aI7eReqdU1bZ24Z6s7RvCbQwwtVX44prOGcDqWiqy9Y0iDoa0G83zXG1PCdg0Z9s
         3XbBx+KIXoVsTPBvJh3iz2u0nvMJso7cLGZLUM8emH1pe8YmZlwWFDwcryvxqZv9RBx8
         9GSILqSeH5g6YEO/tih6sVlw9kqeREYbU/eg/i7KXHYjzxsmkKi/tEtWXFkAwlRKIT4F
         wGafQicielYAh4rwHgHAeCm+sMdpFDFYtUvN0WBTYY4QR8N22HEllf6YlB/oN15gFkgo
         p087LJ4RX9YNGRnfZUgKwK3ZV0v7ctdDROLPpC0lyJvNMY5VjbLmQZw5n2I0lngwalub
         rgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780262502; x=1780867302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HK+FQZK/X2670pSoGvJT+eXxMm/YbYUTBbsmMo4Pt1U=;
        b=RpiDdBlrUWwdgm/tv+6Zw8K3BUehDW7jJ3VuzFvkUil3GqjnTUhBoZRuY+QQvauuri
         ZzOxQ3aqbj8a1OjOriT47u2BRZ0iY6GYUMyWSnw+taGiwF4k7xpWv1az0AsFsHXq+4gW
         85MpsAfpfHeMPA4fNL9WJ0oBtPEHZDFlnX0mt5cbt39+U4Yx7HVZBUvsqLv/l1dh61JO
         Rd2ndaejGZaV4VPBWdwwizisuojBNp7DfE9fjlgdGWoOHce0+WHT6E7L/IQ+0my6eKNb
         3JEYzjZOAgQlGy8p398MSBjt81l3M9daTSIPpkR0CwWxrOPFTlOQjgmj9xy9tD6cyvU5
         kHIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9e1bCZwDm18ADi2eZOTrDla7X0QfEuNLEIY26IBl7HaWPa6hHWSgNHbQZC821PDc3ezo4RnYkxVRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWMHviAYLwtqSZwM4T6WB/Y/mdmtrdi86OfveZBPNbvlTHAZV
	OvhxRwiaDnUt/w4vLN5B8gDZaNsaFAElmpi/q+qIvciqe2LArlNtVaBMhPMBAtgBUaFy+2NGIxl
	mCHoltfYamHcH9VGVi4LlWUgLXnXN8Ns=
X-Gm-Gg: Acq92OH/CsjFXs5LsCYDOROw6LMbB2DafYd7d/oj+oEUGpeAN3ej1RQVHQLdGvCp+Vh
	LnpSgKHuKj5nXRrM1ZFoAhJJOs46kHn0VLYGGxRwyOkZC/CkqGLeg1jitfQFHH+sKqGTSEfUWM2
	E5GH4S8yseBh/lei0wNcrV9WYAcBETIwKkqQ3UUe5SHAxW8/VzbylgQxzNQcEf8zVefXrOG0cLK
	t6M7CfaCuRsxZhGWygQ4R4dODWowteGUHAVf0hUhf8yEPSvEyciQcgzdyBZJs3Fv0GdDhT5kwX7
	qMVbAgZKo/ox0uPApx9RMZCb9xVn
X-Received: by 2002:a17:907:d02:b0:be2:dd37:facd with SMTP id
 a640c23a62f3a-beab4339068mr455362966b.20.1780262502221; Sun, 31 May 2026
 14:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com> <ahv16ogY8Zx3Rtox@pedro-suse.lan>
In-Reply-To: <ahv16ogY8Zx3Rtox@pedro-suse.lan>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 1 Jun 2026 00:21:06 +0300
X-Gm-Features: AVHnY4IV40jpJJDRQFbdKVprCBGPqL0nWYb_1HSlt6FzSI1F6gq0u1bXknLpLA8
Message-ID: <CAPnZJGD5QR5jrNMAem7FjMRTtw+Ue+jm7Dc2Kp8Lcjj+9TDw_Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Pedro Falcato <pfalcato@suse.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6475-lists,linux-api=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,codesearch.debian.net:url]
X-Rspamd-Queue-Id: DAEB3618029
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 11:54=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> w=
rote:
> So, you took an ongoing discussion with an ongoing RFC patchset, and you
> decided to reimplement part of the idea on your own, as a concurrent patc=
hset.

Yes. But I propose an alternative solution to this problem.

Brauner said in discussion for your patchset:
"So I'm not very likely to pick this up as is".
So, I decided to submit another solution.

Pedro, I'm not trying to insult you.

Other kernel developers will decide which of these two solutions they like =
more.

Many people in discussion of your patchset said how they
dislike splice/vmsplice, and especially vmsplice.
Hellwig said "vmsplice is the worst".
Brauner, Hellwig, Horn said that they dislike vmsplice.
They said that vmsplice in its current form should not
be used, and that it is broken.

Despite all these problems nobody managed to fix
vmsplice in all these years.
So I propose just to effectively remove it.

You may think that I just saw a recent discussion and decided
to jump in. No. splice/vmsplice is my topic of interest for many
years. You can verify this by searching "f:Askar splice"
on lore.kernel.org . I simply decided that given
recent vulnerabilities now is the perfect time to solve
all these vmsplice problems once and for all.

I explained my position here:
https://lore.kernel.org/all/20260523204100.553125-1-safinaskar@gmail.com/ .
Nobody answered, so I just posted this patchset.

If my patchset is applied, then I will try to deal
with splice-pagecache-to-pipe somehow,
probably by removing it, too. :) I decided first
to deal with vmsplice, because it seems to be
easier problem.

> > vmsplice(fd, vec, vlen, vmsplice_flags) will
> > be equivalent to preadv2(fd, vec, vlen, -1, rw_flags) if you have
> > readable pipe and to pwritev2(fd, vec, vlen, -1, rw_flags) if you have
> > writable pipe.
>
> This does not work. https://codesearch.debian.net/search?q=3Dvmsplice%28&=
literal=3D1
> There are users.

Yes, they are. But my solution is compatible. vmsplice is simply performanc=
e
optimization. vmsplice will work just as before, but slower.
And, most importantly, vmsplice design problems will be gone
(nobody managed to fix them anyway for all these years).

--=20
Askar Safin

