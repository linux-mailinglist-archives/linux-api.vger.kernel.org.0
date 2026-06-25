Return-Path: <linux-api+bounces-6674-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R9mSKeXuPGp4uggAu9opvQ
	(envelope-from <linux-api+bounces-6674-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 11:03:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE776C40D7
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 11:03:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lOXJoCtW;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6674-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6674-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35EDC3008093
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E621F372EDE;
	Thu, 25 Jun 2026 09:03:11 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD31CAA78
	for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 09:03:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378191; cv=none; b=cvUmI7xWJcosOj1vElXUFXtRrU5hTQP2dIV7OtT7V/wDjx95UTu2uF18O8fBBXAQ70bUojd88wIt95aj/2NhunZsH2LNMRUr8qltnGNTf8Fb28v9mOw/xuMQl4qGbuam/1D7CYYJCHuz7xT2AneyTENlDjH0ZDm0Ep/SZHVsJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378191; c=relaxed/simple;
	bh=FguPNFEFgDgE8rgvKN7AiVQat7qypuBZ+3etEcHfrYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYV+uTBXyWZwnV7e0aqRlCCXXsEQylcRN9evt14OtbYInrGS6v/5eY5RWXGQ0lPD8Ka/CgU4udbcg6bFNJeTmzsvpF1T2cxdSXqYZZM4/jii8+kVHFKute6wK9Lw14pAIJU5Aq+7Lsz2QycXh8OZCAb20wgQMYyFjeG1guI8PZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOXJoCtW; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b9318997so10747725e9.2
        for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782378189; x=1782982989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBSEPUdUYWVlvar6bWIrKaomQq421L3gUjBqqjys/Kg=;
        b=lOXJoCtW3HddOvhqI21M0MrdbMGEeCA203jHr464PdrunmvNXlIQvSoKPMYGOwu4m4
         RFwzCGN4SEIzuyefzRGvqyCJB/GtkeMBWZzjp4qmsNb6mas2NSkYMNhJavf0maEmpgGq
         0vvVPDFPNdbWI17P5aDEiI8RSUl8o1BtTA3eX3kxrgBI6XMsaISmMPROcZfJK7G1h09P
         RzBwVnOWIQCPYHq67uns8cLfchsPhr8HW69dmF0nK2HkL0V+pgurnozJUMe39BUxWAvU
         RpjIZlh296DGwdKkfZklxNtaZWULelbrJR/kq7UqaUkZhA0GlrrRQyRyaByTUYa6sM2A
         BNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378189; x=1782982989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBSEPUdUYWVlvar6bWIrKaomQq421L3gUjBqqjys/Kg=;
        b=q9+N8E6+R0Fb+TGgoGvLSCUBlWL4DyRs9p7tf/v9qvuwTyGha3C2eXGnXRPMbHjXLn
         URdfNrVIdiYJVkS0aChHQtVRUBidG7LnzRYT+KWB4MaamkIibXeRBik5jRGb6OClZyhJ
         VT3SrU1ZFJKRegjnDLc3DRmEyb5ZcRe2TyzorEHAvnnfZEsNz8rN6wAattT94NQyB4Yu
         r3fv5L3jXZvzMHcUJiPN4MTlu41Fl6gII7MhIMTJlNFoTvmfaf9REh0pVkNbLtMmWrDw
         tnzZqjlaEc1WcAEMe2VMb9E3iDgmKHdVcWPpyKdxDswHuN1ZL6ydP7YL7uPtki1dyBNO
         q7ww==
X-Forwarded-Encrypted: i=1; AFNElJ+7/nAbxVkI/2+O8+K5lLDL2tC7X2gGc/PObxRRUj8smqd5mbLFEVVbNmO9z9InR6vQTMueedwHtS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzljM7PHoYPCQhzYzlT/Z1OJokWwC4UvjRKeA1DkZtEiz5Rea2
	nWN9PNmofL5UtbScQzkCjQ3S/i4AfGNSLoQQz6WJAfVyZipVVz+xbWi8
X-Gm-Gg: AfdE7cm7QOi27aUBXl2Ay7xSvaRayTd7m5YZ5vbdmLk/lbOPRj8lOmgaAdJDavPJYXT
	AgpMfO7x2qu7sYGUkiQkD6ekI2BUvjAOgnkAn2oaPv7zOLDSjpTQf2rnHz4qC5PsEweI3gPIxwj
	a+j+RFK9jKouxaeFCXJWNVDDe8lVZ0/RwuaQASIDay6q05ERPgiSMn1QsDX4RTDpUAse5+NqEk7
	AxPK6aUEDGLJl0WyATMR/8zyP37KZVAh57r1OfA1bffsKGmKHjYnb2V8XgKztMh4UL5bLnaSA5a
	hpQfKtic7d8sOKxpt0dbwsU8F1lIQtrCX7RRWso0XT40VHav0sPyeujhAvysnkTDGxqlwuOL7Wo
	MYMHtRiRvjMVlsm1C8HG773GAfzw1iFpw295diM3NC9dDmSKXzQUORZ/DlYsv+ogwUwKxRKOhyy
	e5+Z7uWfgdCu3N5oOCtDk=
X-Received: by 2002:a05:600c:c059:20b0:490:bb3e:30c2 with SMTP id 5b1f17b1804b1-49266885955mr16491185e9.18.1782378187463;
        Thu, 25 Jun 2026 02:03:07 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49265975147sm55948915e9.5.2026.06.25.02.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 02:03:06 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: val@packett.cool
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
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
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu, 25 Jun 2026 12:03:01 +0300
Message-ID: <20260625090303.3796964-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
References: <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-6674-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,redhat.com,lists.linux.dev,infradead.org,suse.cz,gmail.com,vger.kernel.org,kvack.org,szeredi.hu,suse.de,goodmis.org,zeniv.linux.org.uk];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:val@packett.cool,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[packett.cool:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DE776C40D7

Val Packett <val@packett.cool>:
> speaking of fuse_dev_splice……_write actually, this series has broken 
> xdg-document-portal!
> 
> https://github.com/flatpak/xdg-desktop-portal/issues/2026
> 
> Specifically what happens is that the EINVAL is returned due to oh.len 
> != nbytes:
> 
> fuse_dev_do_write: oh.len 16400 != nbytes 15526
> 
> (where 16400 == 16384 (read len) + 16, 15526 == 15510 (file len) + 16)
> 
> After reverting the series, there is no error because oh.len 
> becomes 15526 too.

Please, test v2 version of my fixes:
https://lore.kernel.org/lkml/20260625083409.3769242-1-safinaskar@gmail.com/ .

This should fix this bug.

-- 
Askar Safin

