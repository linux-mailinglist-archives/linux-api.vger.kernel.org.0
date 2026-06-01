Return-Path: <linux-api+bounces-6481-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJS5JEqqHWq+cwkAu9opvQ
	(envelope-from <linux-api+bounces-6481-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 17:50:34 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7766220DA
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 17:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9E473016C53
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2026 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D5B3DB33B;
	Mon,  1 Jun 2026 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V2gD1VsQ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EDE3DA5A5
	for <linux-api@vger.kernel.org>; Mon,  1 Jun 2026 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329022; cv=none; b=M3Fs9FEpXna3igiiOr6MnMSH/nKLlEYIbxTLIPxmre6J0Gb6kG5p+zc39yHlv+QLMBJBO1jlt4ZntY0k8U4s7dnrYwXkDUL8EY2EnzI6OI/F1FCQi2lQRkVCF4AKhpd4r3ZQ51KPtuoqWrVE9nvW7n20b7chTeRGRSl33zhpEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329022; c=relaxed/simple;
	bh=nTXW1aszJ7vJwM4JLdG9/UwnGyXjFaGyj9QAS58OX2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUYdlV9zjKFN9DPCv6vIemoe9Y7VzB+DhziPElGX2hKiBQ5ykqY1FSNxHiVbx0ZvbyZkozu8voi4s6LMbZ5OtcoxmfDxvpXDJccrnrL2RRvv2Xf1kbYfCdVU8fEPmIs2bg4tUUh/pGEkNRoENULGdYa/2048GZwdSonZ/jHYxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V2gD1VsQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bed4cc46252so178057966b.3
        for <linux-api@vger.kernel.org>; Mon, 01 Jun 2026 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780329019; x=1780933819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJkQdYMeeClMSzcCqfeyFg/QAKx7SzNPdhAZ0oh+sp4=;
        b=V2gD1VsQkc3dS9wc9YPXgacroPsWkiRzZ2uAp0RyzLdKsfwCdVnWmCWr3/4GXWzFin
         kqDbtb5hejiXMfgv48ewyO2wjRkKTifwsgrX/Tpn9rAAYuhzUYVebWRMmVM4npEG9TCw
         M1apj7wVlZ8J6zvrVHQlzXxkqJpDg6zLqsMOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780329019; x=1780933819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJkQdYMeeClMSzcCqfeyFg/QAKx7SzNPdhAZ0oh+sp4=;
        b=Ezad/Bkbg1K35afWJk4/j0N5y7jtjRP7t6BuQ3v588a7C4zQRtvNMIkvfWUtrNAzKA
         tvQz9gfNIlXeICoeEOWvQtBL0bUC9yG9jd71Nm+T9Yi9tbGfqU5PZ7bofsharzyvpf88
         4cGNizMN6KGCoMIOYvX+DDJO6GhNVNotgJzU6yWpn3UtVh0CnRnPl10mROL1sdpP6Qq6
         IJqyyIzFdFEz6XyzWIkjrWwi/WsCpAxT0KwNMftD6l4qNIqPjKRnzgvJjtwMmKMu1tBG
         ox4+pORz+X1ZwQfUBRldeFZz2ZQnbM0BHsRDDLnUES+7aPTHEX0iX3g/V/zSoI7YX8B3
         K23w==
X-Forwarded-Encrypted: i=1; AFNElJ/05jsHd9Qh6dXCWdw1qZew7YQmyMcMauHHkCOBuU0bxfRaqQw91W6chNmqER76v7LACxGLYJhCBAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4kktqtvyBQpKxhm6rjxx+yZfSlRHEdicA/xnZPEqaxoX7uWiw
	4hoMBY5dTvtcgcuEDctN8M5VxeMAfQyypF91FoYmCbfJn55Tx7tLK4A4exZW8VKPBSBnO3elIs3
	1rHLvpYI=
X-Gm-Gg: Acq92OHqCfZsSw8N+4UQhHzKBsoVyx9i0IvV/Ascq9wjhE5j6+tnvF+3/RtRStdzUUL
	4HXpoufl6TxLm3cb0AAaCbqiK4shF/npIT6ErK9/YPaegDeM5OjDh80jik8/W5EOABPem5/vbEK
	Xf3imXC+d5cCtYW/UXHSijnUUnGxOEdu1/TnPiaCsvvzyRSJWc6ArVQ94fDDNv43OhS3ScqR6n9
	/k3SnSG9zxVig+qNwHdvguDDz5GDAQOHra7LZKcMEDkWplC5sRmQy/tgae+urQh4HJ5i/vMjI9b
	5DkB/ewuqTZlF5D1cecaMhWl5cDORSrepVjNHQQlsOSWVF4d6Ouw9R/yt5T557O8hxylBV0uHAS
	vr4nM/KU3SbcwkCiDPywkjqzf/dTD2jQc4aRMbpFlNKjg9uDpwR8SDTfTrF+izbFKvnCMKuQjeN
	aqEmplvehmIGIVcYC+NK95/tkrkniwIJ2BQGXqdYv+khEo6N+O0Mxw5P7afVUMgpipNROqMg0iX
	ZLbcOHimyg=
X-Received: by 2002:a17:906:2929:b0:bec:203f:7466 with SMTP id a640c23a62f3a-bec203f7742mr316411366b.8.1780329019347;
        Mon, 01 Jun 2026 08:50:19 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb844b5esm2265471a12.17.2026.06.01.08.50.17
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 08:50:17 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68acf0a15b3so6773184a12.1
        for <linux-api@vger.kernel.org>; Mon, 01 Jun 2026 08:50:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/TJQOarSYJnrWjYC3ZSUZul5bwU2SO33eHIwiOclZe9nrr/uTr61M3h/jNYLwGPIZ+JtyBdjS9zaA=@vger.kernel.org
X-Received: by 2002:a17:906:2929:b0:bec:203f:7466 with SMTP id
 a640c23a62f3a-bec203f7742mr316403166b.8.1780329017245; Mon, 01 Jun 2026
 08:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <CALCETrW__=8mSusayfXG7UFCfue5BGbx+vqESj1d9wqOfX4s8w@mail.gmail.com> <ah2nBAdsE5vVJ2PL@casper.infradead.org>
In-Reply-To: <ah2nBAdsE5vVJ2PL@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jun 2026 08:50:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
X-Gm-Features: AVHnY4JDfRzuLw7CK_4gSBHmXbq5FWvfpfspaVnl7J1jkuJC1SncFOzqHbctZiE
Message-ID: <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Matthew Wilcox <willy@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Askar Safin <safinaskar@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6481-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amacapital.net,gmail.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk,suse.cz,kvack.org,kernel.dk,infradead.org,redhat.com,linux-foundation.org,suse.de,szeredi.hu,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,mail.gmail.com:mid,linux-foundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2E7766220DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 at 08:36, Matthew Wilcox <willy@infradead.org> wrote:
>
> Can we review this series properly?

Well, since it pretty much is what I suggested a few years ago, I
certainly won't NAK it.

And the patches looked very straightforward to me. Just the final
diffstat is worth quoting again because that certainly doesn't look
problematic:

  7 files changed, 33 insertions(+), 204 deletions(-)

and it removes that GIFT flag that was truly disgusting.

So I'm certainly ok with it from a "looking at the patch" standpoint.
I didn't _test_ it. I don't have any workload that might remotely
care.

I did a quick scan on debian code search for vmsplice, and after ten
pages of entries that weren't actually *using* it but had lists of
system calls, I grew bored. So there are likely users, but I don't
know what they are and how much they care. It *might* be a big
performance issue somewhere. Unlikely, but...

         Linus

