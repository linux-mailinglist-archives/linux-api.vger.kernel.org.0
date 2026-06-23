Return-Path: <linux-api+bounces-6643-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wbxUB5RVOmpr6QcAu9opvQ
	(envelope-from <linux-api+bounces-6643-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 11:44:52 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DC86B5E4F
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 11:44:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YGHMw40j;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6643-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6643-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB36307E6BE
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2026 09:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD083CF97F;
	Tue, 23 Jun 2026 09:42:46 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81443CBE6E
	for <linux-api@vger.kernel.org>; Tue, 23 Jun 2026 09:42:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207766; cv=none; b=RKCEc4byJtP8z60wRE2BZYmLpDRs/W/gmMIzKQWyju92DU0LsLAvkpKy7VXABH2nqwEzqhYA362TCyeVJKQ5ZX/r/l2HELnOw/OLke5w0MNvqj96WvPp58j0N0wT6jlvNm+e1o/JGTm5iiLGz4iZZ1Xo0GdKOPZoE6vbj+e5PHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207766; c=relaxed/simple;
	bh=B8aiSRXgNzNgIcTsqvlM+jiX5YYMrahhBOPApOswCwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUdWYfNaGBLL0/SIr0DOlh40/GrGbCD60d3PSmAS61DdzyJRPqkwf0kUWlI0Q3M8g3Ts32vZfSLuttuLu3Q4gUehugpuTZCp7cKmAP5OsfkDTtMsMv9g3+ncI2uJtNZ7Jws/rlJ7EApC5ptK3gWzvLj9D2qtVH+DM5eMfu5D7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGHMw40j; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b9318997so37043135e9.2
        for <linux-api@vger.kernel.org>; Tue, 23 Jun 2026 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782207763; x=1782812563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SJWx7Zgz0Pyhs4JZwrYmJyYWWMlxydwzpM41quzKVA=;
        b=YGHMw40j4hj6TfkUnHCRzMeFQvWey1PFjYwC9WxoimkjXSyYUToNiCRRG3XizMJyVX
         R4ai/ZAAtQDz4f0JWVvcuKQwNrd5Txlkb06UI4Ip+E8l4eB26vkuxuFn6OwMwOYXB61O
         kCwX0AeABcbrjheN/oka2jvup/pAupU+T8RVm3c6KdjPN3Cw8ivsZFWQa+3luBAcmyHJ
         J/ccU6I5B7wsmabeYLLM2iBu+F6a7H0unq3OEVcxPr0XIQHv8J7AknumxKhEAFyiYQs6
         +mqpx2Bs3bCk6AORQ3O0om6vm75JrMhz6Uyb5FEYTnIsi88xM/cBebtwCOEISqrxBiUn
         GWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207763; x=1782812563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3SJWx7Zgz0Pyhs4JZwrYmJyYWWMlxydwzpM41quzKVA=;
        b=tXX5lXL0dZUlj3cdGFEcd8d0xzZp+S+OnVu5PrHIT0jueg39Or36afDq2YAMQ9+YQM
         bZrsZFaJ3kqO/CNDfgtgZ6Ma3TncpGWicNqu8uEVkoomYwGDokk3PkJQ6urJyRbUBuBu
         OC93gDZiA/9mxjPuR1vEchGFQFhdwxKLQ7pcbzH+17zi6O+pTESz87m7zAmOJY9foXqX
         RJVa5IEe9wheTdoZDGG1zpRQ7Gd4b4zaGD3DcCpfsOa8zZXi8ygvb4maWNT10BByiywG
         FH495RsUlaiDz4cNU2ef05iufDB1SkVOjx7PKeHmOHKm2xkWWRhHnQpu9WclLlXzSK8N
         38eA==
X-Forwarded-Encrypted: i=1; AFNElJ8ovtWk9xaWPKAKDi00zRYsvDma/2qoo9pRiRhySjpaT8rxpUmiJFlREFhAtR4twJbLjtK4zZDPUFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFC/01hs4TGH7+XWnamqjN0jR1l/EjJOC61VvKVX1EHoPKhhQ
	b1n+LyaS/3qWQXfKTWTz3hGpMmoiIV61dpT9MbaDCgSqp1hRn8TWNYw1
X-Gm-Gg: AfdE7ckMaK5JEJfz5lOCNixrGHeAhMz4PSziTTcNbfioD/bt0g54hxeWpI+ttonMLXo
	EV7J56UGXs5jt79g5cMM2SZPIXvFakmECPIdGqbd3PNoVtj9LxkSXVTFHhb5zS8tSXfS1PLyTrV
	4NVylWsdTNw3/vxKIqW/+smMaFh648FXhNfOYamsW6PAxkjER+Wj0Y7Zm+iYMBWWA2s/3FwgrAI
	2y4uljJUWpSf3WQi5iX+mwklKthiUcAdlCaPL2y4sMmhnNbyc6RIoEZmmOVtqp6qogSToRYSOhG
	IIw4phcQYWrNNUMtl0VbZXgRde8dBcMMRtT0QyWGrqc3q2JGOS4HxFR0jtyTsJDcSrk9axQRZqZ
	Z0IYCxGJU+2cIv9pG0nb6McVRo68UEd/rva8/u+ZDWM6LYr6O0u8A9w5iow3t4p6yRbzND783xF
	0Gen1hyuF0
X-Received: by 2002:a05:600c:8b8a:b0:492:2e48:81e6 with SMTP id 5b1f17b1804b1-4925b389b83mr30093645e9.4.1782207762970;
        Tue, 23 Jun 2026 02:42:42 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49249455302sm280248525e9.15.2026.06.23.02.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 02:42:42 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: avagin@gmail.com
Cc: akpm@linux-foundation.org,
	alexander@mihalicyn.com,
	axboe@kernel.dk,
	bernd@bsbernd.com,
	brauner@kernel.org,
	criu@lists.linux.dev,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	joannelkoong@gmail.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	val@packett.cool,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Tue, 23 Jun 2026 12:42:11 +0300
Message-ID: <20260623094211.1080873-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANaxB-xVCP5HSUNwphFrKPdW0Qh1pA33A6npac60WArkZMFt7w@mail.gmail.com>
References: <CANaxB-xVCP5HSUNwphFrKPdW0Qh1pA33A6npac60WArkZMFt7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-6643-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,mihalicyn.com,kernel.dk,bsbernd.com,kernel.org,lists.linux.dev,redhat.com,infradead.org,suse.cz,gmail.com,vger.kernel.org,kvack.org,szeredi.hu,suse.de,goodmis.org,packett.cool,zeniv.linux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:avagin@gmail.com,m:akpm@linux-foundation.org,m:alexander@mihalicyn.com,m:axboe@kernel.dk,m:bernd@bsbernd.com,m:brauner@kernel.org,m:criu@lists.linux.dev,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71DC86B5E4F

Andrei Vagin <avagin@gmail.com>:
> Actually, this change introduces a performance and functional
> regression for CRIU.
> 
> Here is a brief overview of how CRIU currently dumps memory pages:
> 
> CRIU injects a parasite code blob into the target process's address
> space. The parasite invokes vmsplice() with the SPLICE_F_GIFT flag to
> pin physical pages directly inside a pipe without copying them. The main
> CRIU process then takes over from outside the target context, calling
> splice() on the other end of the pipe to stream the data directly into
> checkpoint image files or a remote network socket.
> 
> I ran a simple test that creates an anonymous mapping and touches every
> page within it:
> Without this patch, CRIU takes 9 seconds to dump the test process.
> With this patch, It takes 18 seconds...
> 
> Plus, it obviously introduces some memory overhead.
> 
> If these changes are merged, we will need to completely rework the
> memory dumping mechanism in CRIU. Using vmsplice() in this proposed form
> no longer makes any sense for our architecture...

I just have read some docs for CRIU. I found this statement:

> #### Why `splice` is Better:
> *   **Consistency via COW**: The `SPLICE_F_GIFT` flag ensures that if the process modifies a "gifted" page after resuming, the kernel performs a **Copy-on-Write (COW)**. The pipe buffer > continues to hold the *original* version of the page as it existed at the moment of the `vmsplice()` call, ensuring a perfectly consistent snapshot of that page.

This is wrong (with released kernels). I confirmed this by testing this on my current kernel (6.12.90).

See the code in the end of this message.

If you actually rely on mentioned consistency, then, it seems, CRIU is broken.

So, in fact, my patch actually brings consistency to CRIU. :)

-- 
Askar Safin




#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include <errno.h>

int
main (void)
{
    int p[2];
    if (pipe (p) != 0)
        abort ();
    char buf[1] = {'a'};
    struct iovec iov[] = {
        {
            .iov_base = buf,
            .iov_len = 1,
        }
    };
    // I pass "SPLICE_F_NONBLOCK | SPLICE_F_GIFT" here, because this is what criu passes
    if (vmsplice (p[1], iov, 1, SPLICE_F_NONBLOCK | SPLICE_F_GIFT) != 1)
        abort ();
    if (close (p[1]) != 0)
        abort ();
    buf[0] = 'b';
    char buf2[1];
    if (read (p[0], buf2, 1) != 1)
        abort ();
    printf ("[%c]\n", buf2[0]); // Prints "b" as opposed to "a" on Linux 6.12.90
    return 0;
}

