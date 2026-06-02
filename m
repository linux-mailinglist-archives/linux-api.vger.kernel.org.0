Return-Path: <linux-api+bounces-6498-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nERGNIpgH2qUlQAAu9opvQ
	(envelope-from <linux-api+bounces-6498-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 01:00:26 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D64A632BBC
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 01:00:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J5lBxgVZ;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6498-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6498-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 096473017517
	for <lists+linux-api@lfdr.de>; Tue,  2 Jun 2026 22:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECC33CAE6C;
	Tue,  2 Jun 2026 22:54:36 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E53B5E07
	for <linux-api@vger.kernel.org>; Tue,  2 Jun 2026 22:54:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440876; cv=none; b=ajYyTsx5TmuhjgQvuTUSJALltYCs7lH4Ax/OjxfLSCgK0tF4PAwfPbse1YUJxe+bEd/6tarn2zgmAP73556nnxA66ylXYaplaiy8pA/Q4B7zfVrEhHNY8Gz8mKnA+Yi9ezgyV2I+fs6zapIHYPtVRzm5CerDF5jp0HH7PIvjeck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440876; c=relaxed/simple;
	bh=X+6iZWTfWXpo410W4glUkXVe/Shkkk6QObVykw+rX6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8n32Ckb7i5mo12aGq7QMkGFRsnWZ/Et4EkE+ieHfS8olW5UcCjhT+5FF00uDSzlo2I+n17TVl+PbDD3f4Rm15IqoloSqanC9cYFbqsSRPMkmsJnxqelmGAjU3OJcQI7eRDOYii4DssFLChb+9Uequ5mAFCORvegAqWUL6kLJXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5lBxgVZ; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso1785677f8f.2
        for <linux-api@vger.kernel.org>; Tue, 02 Jun 2026 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440873; x=1781045673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jl73xD6zIPi47mu1jowzc4phm5baQXMI7icQsNN3pI=;
        b=J5lBxgVZtN2FI/ioqwhDNCosN/jZxozQdxLdEv8Lsv6+u08aS7OxTXrQzGg72R791Y
         z32rVB76ykLqfRKHMQDiGLQGAmHWCKGHI7AiNnVW1XWIXiMnT2eX5t7ZtVn5WJ9pzdxr
         bfL67m+3y26zQeyeaJEk577celexSXvREDjuhI0lTlSDWcyIshaKWjaTihfPmJhfCIwd
         MH7OAX39QaAQh41d1ecKqz0qNgVt+7a3qN85DYTIMQaZ2dwdMsWfE0NHmsWsCaSLpamn
         zO79gWY9UqRLT9WZWT2xXwMwr6B588h+pNV2K+1vQX1dtxuAKvd+s0Ou1C9kqMvX0vVP
         NH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440873; x=1781045673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Jl73xD6zIPi47mu1jowzc4phm5baQXMI7icQsNN3pI=;
        b=fuUtv2z4biK2+Dgtt1c9VMDuJ4H/LETViBiOiZH7+GUHfGjNFUbK1yiT1miVW7HMjd
         lXV5M691AGuRm/ZFdpPn50nP06ENcIqaIdjd/8N1bFibz+kixkQ4xTk/fkHfnW3w4az6
         3sN6YFepv9iLlK9Ax+1vJ0PBShbTajmtK73yBsorMhsnZ0UssGJzZSGtFp40y44Q8i1F
         JuM+2tFbjCWRDJWhjirWwWNtT5jA419izSF3qkKab9qLj0RUiDrJoXoPAFDWldwO/0S3
         t9hgG5T44zI5AQ98V1Avw6GdziNEl5lG6NmkgDdC99sNZYZl+5Bg8a8n51drsaP1CZ7W
         k8kw==
X-Forwarded-Encrypted: i=1; AFNElJ/S8idaQfGwf4xxPb2tjguMJml9W8q6kTj64PpIwhG19mIRyyLy7lOSSklluS+xy/nd6MRV6xu+Hw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwjWxgKw31urHLwujAwJ/jzqo/iNTPUYyiSApjlmqlAkymPmn
	GkACjpjETnVGMYFRzjRCPUE59SuFkn16yX6070FWhsM8e9PZcyAKzR7D
X-Gm-Gg: Acq92OF+EthpgbfM1q+MnfgyWWEnthrMd0aIWuer1nvgeAMj4n2QcOZ7t9nNaXmu9PV
	5CyVMFwX22wtq9gSxbF2XL++QjjQ70qOcrHp+9MaC5O/NCpjorJHtQfWKnnipoXo4cEHVCyVW2l
	Jq0vmp5gyocMlj/dGJaASTRXp4gmlO1+063mKUNnJAHwpw2CwZku0sehBrcI/8zpKpKF2yZcfxJ
	ksY5AOP01qrqS73XlPnL5yxbJ+7fO4adcxuEbvXziM7aPi+fU+vUQodzSsu3SNodStpFO2rVLcS
	2GkwMD1nrfWrkrzrf7rCUIr9uiLp7PRjQ4miTSLCD1aGcIQIkGxeZ55gNR0CGH6BmRK8WMpkA6G
	W2Fk7QBm+4G+3J2/gu+ya6Ca2UhPmA620i0c17KlTGm0btqhKJhomokYUTKn38lmFR+dR/eZoP8
	3jYnqadd1PIFXkdx4oCbsaz0M6E0f7wHQJxeY1z5Dk
X-Received: by 2002:adf:f58f:0:b0:45d:3cb0:5ab1 with SMTP id ffacd0b85a97d-46021873b26mr407422f8f.38.1780440873290;
        Tue, 02 Jun 2026 15:54:33 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2dc577sm2550100f8f.3.2026.06.02.15.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 15:54:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed,  3 Jun 2026 01:54:26 +0300
Message-ID: <20260602225426.122258-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6498-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,gmail.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:safinaskar@gmail.com,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D64A632BBC

Linus Torvalds <torvalds@linux-foundation.org>:
> That isn't what Askar's patch ever did.
> 
> You apparently didn't even read it.
> 
> Honestly, I think you are the one out of line here.
> 
> Askar did something I suggested years ago, and didn't remove any functionality.
> 
> It just changes vmsplice to be a copying model (one of the directions
> already was). It doesn't change regular splice at all.

Pedro is talking here not about this vmsplice patch, but about
my future hypothetical patch, which will remove splice-pagecache-to-pipe.

Let me clarify, what I want to send: I will make splice-pagecache-to-pipe
be a copy. I. e. this splice direction will continue to work, but will be
possibly slower. I. e. I will do something like this (see end of this email)
(absolutely not tested), and the same thing for other filesystems,
and also I will remove resulting dead code and remove
pipe_buf_operations::confirm (it will likely become unneeded).

If Pedro sends this instead, this will be okay.

diff --git i/fs/ext2/file.c w/fs/ext2/file.c
index d9b1eb34694a..8edcc3769793 100644
--- i/fs/ext2/file.c
+++ w/fs/ext2/file.c
@@ -326,7 +326,7 @@ const struct file_operations ext2_file_operations = {
        .release        = ext2_release_file,
        .fsync          = ext2_fsync,
        .get_unmapped_area = thp_get_unmapped_area,
-       .splice_read    = filemap_splice_read,
+       .splice_read    = copy_splice_read,
        .splice_write   = iter_file_splice_write,
        .setlease       = generic_setlease,
 };

-- 
Askar Safin

