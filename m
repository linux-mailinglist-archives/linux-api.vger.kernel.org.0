Return-Path: <linux-api+bounces-6545-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fa5cLWkJImo/RwEAu9opvQ
	(envelope-from <linux-api+bounces-6545-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 01:25:29 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC0D643F16
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 01:25:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="g8uIh+N/";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6545-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6545-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7A50301E6C6
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 23:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A5036A36B;
	Thu,  4 Jun 2026 23:25:26 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C82DC792
	for <linux-api@vger.kernel.org>; Thu,  4 Jun 2026 23:25:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615526; cv=none; b=XrHXUOEA2263vNwx5k8mrfJ5gnRweGZMbPZ8Yw+xNTpFRKJs7HVtm6JoHdyE7k9Oh+7Rx7CYfAw/xoNNEmLrHtNvH66CsvjlHJtc1tjDPW/E+Je5UQFNeqbV/LLMzxSfRb/3XJA2zzkWE9c5wn/tW4GsAkEtorompPQp2fC3Vkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615526; c=relaxed/simple;
	bh=YcOxrIBH2BpZdGTvyCaML4gFpZ+luYLhgZonf1vLcN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0IteuXMMFjkToWwa7QM+DEulLOnvy6lopDCXcF4me/vMIZ58hfiPM+f9Rr8+BSgskjfiX8TA+W42z3f1H3E2KH0fVmNc5i23LyNoHlYck9IP6dlvLf00Qk8IOJaOgWkEJ3suvVoPonRf21vFN2psTM1B4OAH4vV64K+mfk0u9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8uIh+N/; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef372c58aso762628f8f.0
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780615524; x=1781220324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afznK2o04gyhM0m9icIwY9Iwej89NrlffaDAhI1G0qM=;
        b=g8uIh+N/gdQjwBKnp8QdM9UC7AMhZMoMFU8x1+4Nf1ZixMgj4XYvZIbuX9EqRovwBv
         Xw9+5F+0jLfMHdKAAPFVf3gR1uRH7cCtjue6ZtQEu1m6Qp90KFSqnsD1nfnvo/+epSUf
         UuSmNyxrGH5oghtP9hthV2injV46vu9dbeCW0S7A2wm1e1tpF+EDOGpG9YyVn/mFUV1D
         HgbUH8Jnvhppr4ZA/HqfrYbMCP2zQdbv8w+0wuBgort9e/YSfdtShgpq6FiaxmaaAwVI
         fm8QHsDDQb/4bNz2RtQ9KCmqj2lg2xxygCSqX83y4EeI9SzIg1haUi1zhbfPFczjBEBk
         D4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780615524; x=1781220324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=afznK2o04gyhM0m9icIwY9Iwej89NrlffaDAhI1G0qM=;
        b=mqgYM6vNTFChwfQcCuxzEToGP0fuLskqLFtXkKwTfTzV835Br21N5h5kHTwjAByFC8
         7fbPY+T/GVnvaKztYfXiHZJsKF5jgNLe3n7fuafS9bqbIvQFHCDgIl5F2LCeD6CdZMgd
         4EoRPW73zvJwheFiued98jGNdKLFw2ps7+NCrRIqJXvvzWL0MZrpGV5sBAAwd+xGHprC
         cAVxJYyHGOA2Lff8quhUXJf3EGoRRfkvn1dBTC+CNZjWfgJZ6c1ipfRIm8Q6dRd/wGUn
         JrKE34EsIkKnotMDYZwu3pqoJQZ4cvklkkEtUM/ElbNUet7Dxg5ZjkGyGs7aFg1ZLvZW
         2g4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/LTTsnpDiPtsp5gYj8UEIGzJe8ZIR8cQ/YlSFJ7Hh+lJ2Z+CtfmO2QQyixRNynTYx0hnUk/J6VX8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnCQM/Yc1R+bTzk+IETQ/Av+9J1/ai+bnnoUJd7LdKHe7NeIeZ
	MlHumNZoa66kv/DWhcvYz1hFt7mSYRTq/qCf0KL5ExwatN9zTe0rp1vn
X-Gm-Gg: Acq92OExQPGVUx3eSLqWvv+8PfFgO0tWOMa/cGYQI1E2efJXRhOYkd8p08TXct4myQV
	/TVYb04Rx43wLmzLGpFwtFaWnF5kndCjwhQZ2bOzNYrN0rq8RSK74KeF+n3lVSVQq90Od90rCW4
	KNJB18gGGqSCukW+bJ+VjwgTgyT8pnfPaYac7suFAok/eczNWZ1u7AEKSRXbIaTEyKvO/d1cTDN
	tjpwvaXaeUAZ6wIP/AI3H8GmPEPfga6X1mcu35/KF9Ocl0D2Z3sxScZCwgqvnLCBPwn+RwgKlz3
	OipraMx7Ts90XcFrfbsL+EMyhf1O4wcus6aiItOmbAVYtr+M941qC5S8iVx9SWrfViVJsniazmH
	KiZfQ3dDIdHqWBlD4hLtoRnbeo36inQp5RYBcJGHwwbHiTdfMtpQRx4x1SrD9CwdQbRglKjxVLW
	kjRSyuPKXOBXgnIAJEiQoPfAzr6Umc1A==
X-Received: by 2002:a5d:4e49:0:b0:460:1ab4:6623 with SMTP id ffacd0b85a97d-460306429a0mr1128044f8f.27.1780615523601;
        Thu, 04 Jun 2026 16:25:23 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f3529e0sm20375107f8f.28.2026.06.04.16.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 16:25:23 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: david.laight.linux@gmail.com
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
	metze@samba.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Fri,  5 Jun 2026 02:25:18 +0300
Message-ID: <20260604232518.1896014-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604183829.63c35fd9@pumpkin>
References: <20260604183829.63c35fd9@pumpkin>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-6545-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:metze@samba.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,samba.org,szeredi.hu,lists.linux.dev,suse.de,gmail.com,zeniv.linux.org.uk];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BC0D643F16

David Laight <david.laight.linux@gmail.com>:
> I know it has mattered elsewhere, and is easy to get wrong because
> 'mostly it works'.

I will send a patch, which will change that argument back to "int".
Hopefully today.
Also I will add that "wait_for_space".

-- 
Askar Safin

