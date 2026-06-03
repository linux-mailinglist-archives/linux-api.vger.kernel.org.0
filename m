Return-Path: <linux-api+bounces-6503-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gO8nNaqrH2pWogAAu9opvQ
	(envelope-from <linux-api+bounces-6503-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 06:20:58 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35427634212
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 06:20:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=BwqwcuOk;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6503-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6503-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85B563070F26
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 04:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6EB3F1ACA;
	Wed,  3 Jun 2026 04:20:37 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D62FD69D
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 04:20:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780460437; cv=none; b=lcpo3D/bjGikG/6vI04j/oJ30wUgmHj7UE0NeqGhkLpFfXP9/fDXLtiPk82TUnPttpkjIgxDS5uan477mg4u64t6w6XVDCPgOsybQC7UbRj2WaAU8PaMOBNCqgGQuZjkoGyYdsyADLQLHV8NmttzoRPmYjRysweCRzzPg3PWOXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780460437; c=relaxed/simple;
	bh=9tQqNP43n5romnaq4BfFL2SfXA5Di4eDVrUHKrBpUCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fg7PaQm3Tvm5ai7NEubzHfFYpcs5oxGWI3F9n8ZXlyGll2ljRRqV3rfRS/b8lPsQzrRs23B+MOs0kS+qizcAJqBL+1y+JkYbmrpGvjRl/kVgNjuogDIZeaJ48NeHm3uLe3Ioc8H0gcYcElz0tuhfb6uHc7Yj82XmRQytNOCkg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BwqwcuOk; arc=none smtp.client-ip=209.85.208.43
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6886be3d39bso18683390a12.3
        for <linux-api@vger.kernel.org>; Tue, 02 Jun 2026 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780460434; x=1781065234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3SJtr+8Mfjo1TPz3VKjCaH7CMP6KY0W4WXb69Cl5TnE=;
        b=BwqwcuOkkNb7tVHZLaGh6eXbo44FrMSBRw/0cHRTu8+ebGPkDPXOQ26GmL9HXReqa0
         Za1J/8tdIswPmx1kycMHEmhHsY1kWxLt/HPSfFM5jFGH8w9WPEhHo3LsDQVDjFl+MRLs
         tPAgmN7XEkogdSBpppp7LrsvFAQs1sixquNZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780460434; x=1781065234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SJtr+8Mfjo1TPz3VKjCaH7CMP6KY0W4WXb69Cl5TnE=;
        b=G/sZ4hC90o03grLKVMVl0rIVKMkXpkSVSQL+tojrubmnnUJZMblcBkG5hqzP0J/tQd
         tsXEIA3Horl0DzOuA7bNecEJDGFtonlqjs5uyfGbcB1IUWfGsdcdH+w6G7f2JFfkK+Vc
         s5ToJZxe2fuOiGxnZuNZAJHnymM8KMQb+ea06b418eeBhyy/23Z/L8NwszCyCiJKpGCX
         HgvSMKXjORzK0Gw/8K1bNZNmJ+EHGen0uhmL1+c1L9kdtNmcVeJFJTPDNbRuFcc5zLuD
         E3u5l5S4XNgboWD0ZcV/IbChe9DMAh6dEY3udIX60PsIX6bs7OcyKZKLI67o66xNsDMw
         wJuw==
X-Forwarded-Encrypted: i=1; AFNElJ87fu8KWQTxCsPzBYTpDx7YllfDsQUD+9x3AljEDeoKGXPfz03jfr73qowsiv8RIHTbcYWn7gO7ais=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYYZdihTjnV5sFs389QzLMp4/fAgoea1DpGk70YmK1EWAxE0P
	2VBek2Ll32bRCONSv9Lz8vO0Y/X5hNRia9duJUWuGSmN4aIy5r6EkiYthb/1VxKyRBK07K4agwB
	7hypRl1xP+A==
X-Gm-Gg: Acq92OGgcVuycy9k4+86NEyRw+ZF3/1DyTsZK2ytX5UlPy5tk8KzGrypZUYv9UvlJWk
	rLZgku3RSH8tn2aOvFY7AtGqDlgLrvkksoJqxX58+MjDDZDmEJHrgi1OWWJ6j2BjK39XnzSCKEO
	wV5qzNtc/XhVYaXhZLG4aTAGUhICNJliYb7A0YSrCbIzadE83c9F750yS1Zbjbl5Kkx/BbbJHoq
	/KD7LVn2JqgZCr7vq10qkCtQ6SPrmh7+vm3BLcHnjL9hZmpYn2IH8NDVrxFSI/OgPyYWLAi0N5X
	A3ZjMah5607ndhKFpFpRiyxzyj+vlNdcFjvEHBQgzwu9CIicEj2iNHsUqiRs0E3CmhacsEdeKNU
	no5fOZ1vo84CPijqFAy1TqHtmFOxRFd351Ya+Gtj1cjZbEgdEte6egmtqe5KWeePOvg0WoqoqS4
	E6Qo5kFLASIFTmC2KOnTAKoVMRiU8FYwzINpSRoSEK53CwjErtOd2ghDmTcqeDtofyTU42bHmyJ
	bMe4KYEu+O9xUC13rxUXQ==
X-Received: by 2002:a17:907:6d26:b0:bb7:eb68:514e with SMTP id a640c23a62f3a-bf0aed0cafemr56816666b.36.1780460434063;
        Tue, 02 Jun 2026 21:20:34 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e051cfsm75946166b.38.2026.06.02.21.20.31
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 21:20:32 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec49f7e35eso427287166b.2
        for <linux-api@vger.kernel.org>; Tue, 02 Jun 2026 21:20:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8yZHBKkarWHjb9cJ3T4/VwqeDy7EN9sayQ5MBB4uIxXAKSrqdcmj2nwTtlx7ghLKAJLeG8qB8ya3Q=@vger.kernel.org
X-Received: by 2002:a17:906:8a48:b0:bea:4a9b:27e3 with SMTP id
 a640c23a62f3a-bf0ac20eef3mr38881066b.2.1780460431308; Tue, 02 Jun 2026
 21:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
In-Reply-To: <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jun 2026 21:20:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
X-Gm-Features: AVHnY4IJxv2Bq-ytG67gbyDgK2Xm9CPUNF4PNLBHu-2R4s_ONl3Jl_5fsF1zxk4
Message-ID: <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6503-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amacapital.net:email,mail.gmail.com:mid,linux-foundation.org:from_mime,linux-foundation.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35427634212

On Tue, 2 Jun 2026 at 20:51, Andy Lutomirski <luto@amacapital.net> wrote:
>
> Am I understanding correctly that this will completely break zerocopy
> sendfile?

Very much, yes.

And it's worth making it very very clear that ABSOLUTELY NONE of the
recent big security bugs were in splice.

They were all in the networking and crypto code that just didn't deal
with shared data correctly.

So in that sense, it's a bit sad to discuss castrating splice.

But it's probably still the right thing to at least try.

I've seen very impressive benchmark numbers over the years, but
they've often smelled more like benchmarketing than actual real work.

There's also a real possibility that a lot of the sendfile / splice
advantage has little to do with zero-copy, and more to do with the
cost of mapping and maintaining buffers in user space.

If you are sending file data using plain reads and writes, it's not
just the "copy from user space to socket data structures".

There's also the cost of populating user space in the first place:
page faults for mmap made *that* historical copy avoidance basically a
fairy tale.

And not using mmap means that you have the cost of double caching in
the kernel _and_ user space etc.

So sendfile() as a concept (whether you use combinations of splice()
system calls or the sendfile system call itsefl) isn't necessarily
only about the zero-copy, it's really also about avoiding the user
space memory management.

But yes, there's a very real question of performance.

I just suspect we'll never get real answers without going the "let's
just see what happens" route...

                Linus

