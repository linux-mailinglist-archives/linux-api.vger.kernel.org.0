Return-Path: <linux-api+bounces-6552-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d+gKHZDAImrHdAEAu9opvQ
	(envelope-from <linux-api+bounces-6552-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 14:26:56 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C77326481DE
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 14:26:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=U5IBHMk2;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6552-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6552-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4250F301E969
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EDF2FE575;
	Fri,  5 Jun 2026 12:19:49 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950A2222AA
	for <linux-api@vger.kernel.org>; Fri,  5 Jun 2026 12:19:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661989; cv=none; b=DSqOGU/VLyJHbVqNIHkGnnNHLAQfMMTV2Xk2o3B3yyVj9WvxfIwkLFeTkO6fZAybTSiYTI8SBxRtsaL5ZTdLAwEedEtUKvi4K44XaPk14XNdhO6evbB2VuXzQhHWWeUZKFDoh+je3ZC9eAM6ftM02y1PJSjwlbrCyhefC0QTFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661989; c=relaxed/simple;
	bh=fG5cj9E2nMxzrFq+XWzFsnTRtUdYT3n82TzWC2ntc84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVFDoUvoPJWuAhKf9aGAZI756XbT+X71kU/cxJZxqNWbDKCsna2zjAfIaZm5vydHtMNVJM+2ZTJtaKLeb7ReoFahPZ5br3YIZGY4R7zq7aZZaUqovhjkqcTnMG6lHqrBZugTchzaBYrDwn10Xs3+hX2D5+c4V9PlbmDLHKIGC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5IBHMk2; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so19918355e9.0
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2026 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780661987; x=1781266787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz+VtwQhYk3ng5JxyiUgLQa8oImJtLVBwaLlzEeVzFo=;
        b=U5IBHMk2+rOzS/if0P1kHBKhHO1E+Ya49eQCQst9eVyKYrNqaV/ILHIswx3k/Ya6cH
         uI/Mkj15UuGVafXE+YyfybWXy/xkKIInZpK6pfGSTpv+QymV2+wwfKUmIYjaXlERXnxm
         77xU7BFQ07n8mdMkNY3AlGELiR6XSktldPtw6Y/m2xAzRkqWUu+XCkzUhmgw2vpaELtr
         Lpezyfi7gwsgLU57oqpIBv5A8Vryff8AgqJRoWoybSdb0UY3cA2opYUA+qVE0WrXcR89
         5jpz/98fNXaBTt1hYIX1P8e0rugg6WZ2MlNpbU0QiHlwGKXKS42vNN6OaT420/og3ZdI
         j61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780661987; x=1781266787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gz+VtwQhYk3ng5JxyiUgLQa8oImJtLVBwaLlzEeVzFo=;
        b=Buxu04B/gt3fCwQTLnyRSPK7qd0bHt3JoWZGfVivS/8mAzvFYDWjh4/NNSOaNvfuwh
         sSffSeB+65MYYm7KfncuRda8F7alHC64zqW84nSpwSSrSOdtZjbtvtcBe4OFq3qAUupz
         9Wy+cRpejf/isO9aAohQeHVXmCFqFsFvJg77ymyk5pGLXw9uSDeIZXrZm8euz6wsfele
         fKaPXFzCO4De6zqjOXQzcGdT5ap9/NCvwvnxuA4ZQV9cdXEP99262wMPWL0+npPJULDp
         0n973Z4V+UijGSp+9NSjET8g3dxqLM1KnT4Zh1huX38AlE1ZNuD2ONMUe3DQyIPiw0Uu
         p4qA==
X-Forwarded-Encrypted: i=1; AFNElJ/KgrSBuna/5NemQyJqUtNqoUNPKOFTPkSnUkzEhrj5U1B+UX9dltNwVwjsO8z7AVuqWZWtGDQexIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+eopVQKz1UhALcLDInsnB0p3iV/uGJINWwXWt1XUhuecB2eqS
	kIBNI+0Kjd4gT5YgcWtHAW03tmaeZeNRtoavZE/1W7a/pMPP0rdp/evg
X-Gm-Gg: Acq92OG0YlU9ecCJZgLD0SdNh+tFbnxvGoT8Kb/FXebgP00uYa8+JHMzX1slNBQUmAu
	9oDYM3aZjKFiH/Hov6+wRc6xa3s8yuJeIUj3127JAPgyNQaSs0NtFZLHPy0T9yz48zgcLDZ47Fw
	xIqZrnasn9ZDbHGffar32PFLPUTk42x1AXISmf11zumVljMKaip3YZdxnwzbmUjvoVM6V9Pacre
	4sYOVre6RA1bW4ogAi4SVxiXdFGphSEUPupPZ3OZeJZtQAs37cgwyzhhHtx4TzHmO40A2RhQVDy
	enUENgW+MAZ/5CdhbRY1O6ESUza7+n3XRdYIENFY18EEURROJRo/tmMKruHo73LLUWf3x1y3fjp
	YH0LX/QmcgYxWdv08McM/VxQllezsaC4jm3lVxJNELTeosOznelXC6zSrJCqQ1opMhxhtWGE+qF
	JDBGn7A/+vtMHpBhccnJaNM9kvRvVqVzLtUzBSyibg4lGLFeVsbwbEN6Zteg6xenjv2bed5Tkl6
	LDEDMYnJw==
X-Received: by 2002:a05:600c:1d12:b0:490:7227:100 with SMTP id 5b1f17b1804b1-490c26049a0mr52430315e9.18.1780661986468;
        Fri, 05 Jun 2026 05:19:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm152016275e9.7.2026.06.05.05.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:19:46 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:19:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski
 <luto@amacapital.net>, Askar Safin <safinaskar@gmail.com>,
 akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
 david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu,
 netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de,
 viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260605131942.4584728e@pumpkin>
In-Reply-To: <512d948f-7883-4d8c-b2c5-a777e70ca975@samba.org>
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
	<20260602225426.122258-1-safinaskar@gmail.com>
	<CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
	<CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
	<CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
	<512d948f-7883-4d8c-b2c5-a777e70ca975@samba.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6552-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:metze@samba.org,m:torvalds@linux-foundation.org,m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,amacapital.net,gmail.com,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C77326481DE

On Fri, 5 Jun 2026 11:43:45 +0200
Stefan Metzmacher <metze@samba.org> wrote:

> Hi Linus,
> 
> >> Am I understanding correctly that this will completely break zerocopy
> >> sendfile?  
> > 
> > Very much, yes.
> > 
> > And it's worth making it very very clear that ABSOLUTELY NONE of the
> > recent big security bugs were in splice.
> > 
> > They were all in the networking and crypto code that just didn't deal
> > with shared data correctly.
> > 
> > So in that sense, it's a bit sad to discuss castrating splice.
> > 
> > But it's probably still the right thing to at least try.
> > 
> > I've seen very impressive benchmark numbers over the years, but
> > they've often smelled more like benchmarketing than actual real work.
> > 
> > There's also a real possibility that a lot of the sendfile / splice
> > advantage has little to do with zero-copy, and more to do with the
> > cost of mapping and maintaining buffers in user space.
> > 
> > If you are sending file data using plain reads and writes, it's not
> > just the "copy from user space to socket data structures".
> > 
> > There's also the cost of populating user space in the first place:
> > page faults for mmap made *that* historical copy avoidance basically a
> > fairy tale.
> > 
> > And not using mmap means that you have the cost of double caching in
> > the kernel _and_ user space etc.
> > 
> > So sendfile() as a concept (whether you use combinations of splice()
> > system calls or the sendfile system call itsefl) isn't necessarily
> > only about the zero-copy, it's really also about avoiding the user
> > space memory management.  
> 
> I don't think so. Ok, maybe for webservers just serving tiny
> html files, that's true. But for me with Samba it's really the
> copy_to/from_iter() that is the major factor.

Is that copy also doing the ip checksum?
I really can't tell from the code (it does sometimes, even for tcp).
But I can't help feeling that optimisation is well past its sell by date.

-- David

> 
> We can use io_uring with IOSQE_ASYNC in order to offload
> the memcpy cpu wasting to different cores, but it's still
> wasting a lot of resources.
> 
> For the case of filesystem => socket, we can use
> IORING_OP_SENDMSG_ZC and that at least removes the
> copy_from_iter() in the sendmsg path, but the
> IORING_OP_READV of buffers in the sizes up to 8MBytes
> is wasting cpu in copy_to_iter().
> 
> For the case with smbdirect and RDMA offload with 2x200GBit/s links
> changes from only ~33GBytes/s are used (and the server cpu even if using multiple cores)
> is the limit. Without the memcpy waste ~46GByte/s is easily reached
> and the limit is just the network link.
> 
> Maybe another solution could be having a version of
> copy_to/from_iter that uses async_memcpy(), but didn't
> have the time to experiment with that yet. Maybe a new flag
> to preadv2/pwritev2 could control that, so that the
> application can decide what's better.
> 
> But without an alternative please don't kill splice.
> 
> A lot of people are frustrated because they bought hardware
> that is able to handle a lot of throughput, but
> e.g. with the default of smb over tcp they get no
> higher than 3.5GByte/s on a 100GBit/s link that's able
> to handle ~11GBytes/s. And io_uring and splice are
> a key factor to fix that.
> 
> Thanks!
> metze
> 


