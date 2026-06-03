Return-Path: <linux-api+bounces-6518-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uEs1EhWaIGqf5gAAu9opvQ
	(envelope-from <linux-api+bounces-6518-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 23:18:13 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF94563B5AC
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 23:18:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ua8Hv2Nj;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6518-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6518-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D34843015881
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 21:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672683C81AA;
	Wed,  3 Jun 2026 21:17:49 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBE4963CE
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 21:17:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780521469; cv=none; b=uSuhmvZ+bCRqOJhIuecnK2Q8pTPAxpIqd0Tg4m34Edqu7o4f1FV/DA196vc41Z8YE1dSek7I6PJ8HsaookqSN4q5j7AFd8B67DqvTYO5tq7cJdsLmG6oKzqkXZItrCfra00W1tFRQ6KM+l9hRnzXiwX26mA2mo1wPTbh+pxvKhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780521469; c=relaxed/simple;
	bh=cC2THtMvsKyfTnqSrCUcXu0Wb3XRjrvrr6iNqn0oj+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT68hrIEeO47gFxLdL99dcpR9WW8+n6u2q3s18YD0+K5B/c3igwy1WdsyW9DkAkLMg8Y/qg+R4Wj6kiYaWH5whLOxgjN+/KpJqim/NSCv78AlOrm1dI/K+8i0UMF43wv8iRUiMR25R5bsrdIVyh1VOmfWwOX00trEVa/inun2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ua8Hv2Nj; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so194355e9.0
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780521463; x=1781126263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B/50xn270YOFb+RgL3nLDaMTNlbmRRwqq6mUIoXECM=;
        b=Ua8Hv2NjDhBwpbXMMTrtgdqfGxnxB3V4oAlPhNb4DDqYcqNs65iveFVYdULOA1DUnU
         BpQSPb2jqYNWmHTswSPVJ9NuvC8c3QF0UlPm/8Y6sU3UIdwIVsTiTA4ySbWX/G7kpzjB
         l0ldPPRdq3E2v6BpyGFfJJcFjiEbA5EdsGub/5VE2Y/NeEHsqT+A0zjow9dkaNkwP0gE
         bcTP/gNMDjT7K0dnXaNbQ7lvW9XD5QbrGu7z/Ahs5rnw28hEpIwddzVe6hIMSYlDgi0Q
         nXBTLYmGwX4Kbmn13v+r3JrRAhmIQxzp/nLcZ+8uflc/eKgniCrSVV4qAx/jBkQJAuQl
         l+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780521463; x=1781126263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6B/50xn270YOFb+RgL3nLDaMTNlbmRRwqq6mUIoXECM=;
        b=Qr0aYe8FX91iMn/StshbBmfdTjmwMsIpfu1BSjHX2mGOAuNK4ydzuMqkgvyDyo3JkN
         9I9dtKoOuoRGcBXPaq7LvHUHFM4QdHgLv01ZFvrjP0kNZCMjRjG+j+q97CZtYwcf8Dt3
         FULCqZ4qjpg1MAdoUu/fR57sciYHDmyExrNdO2DKIBZ4zA42LBT2fcGQIvHhki6+LUqo
         HKBoGYAaOBBHhDhVsM8W/5rr3081ZMg9ocb121fmccOSAdwJdmFUbdyRye2lrwtlJ6fW
         UabOwic166Tvi//h/XvOXZhXFFpcDdqnBUUtkIgMomQENihU0foeDULxLJ3Wc0c1C/H7
         SJaw==
X-Forwarded-Encrypted: i=1; AFNElJ9+wASPzP+0rwudzf4L/F6woNOFNSuOwhleouvIl5SfkA+jM71ZS8nkoGLbSYPKPg/aAGHbAMCcxdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxvZGDiGGn4A5O05zeV0v9JnZ3LyDC20y+jBWWuV3ameJEP7B
	SQ9BgsaIsliaJiX5Y/CURPXbr1uZaylJZxzzBDhY0LtmnEkVapN1xxXM
X-Gm-Gg: Acq92OHakz4FNTBVxKh6r+/+Mv1+958/xDcHVCL5LGDE3R5rZm7+zo96pCNvoh0R/5t
	6NheEbka9SS1JBlVoYUw937ybi8PUttFG+IttHOpZEyE6wk+F0ZOSu0IoTT99zebkYmWSZYIsIK
	+aKtYB9O+P44y657ETqr5JsNtMGwjyjr/WDTogvEAmvMIp7ZSrNT3d4U1hJ7nd9m76y+s2ZeV+j
	wpGpwSoFOE/nGs9EHEe7m8f+3Y9wpoyUiF20MqI5X7DuUuCWQ6t4ace1NlKWmG/DkkVCoKDFfqa
	ZW8kdEbMHJIldmilBKE6aLCUyEiicsgzFQQ0EyonD6PgGmdYmEDkH5nN7HwksISjlVECI7MMEtk
	9eOgsLhGuEOBA9OURVNnxYQNZQhiiOcgV0tF/fdnHEGyUUxlSpxW8jpQxLLMsQi74S5aa7dyIoO
	36Yzi9ignU03WNoINo4NT0v87SU6iwww==
X-Received: by 2002:a05:600c:19d2:b0:490:7136:ad02 with SMTP id 5b1f17b1804b1-490b5e94d63mr81490465e9.7.1780521462549;
        Wed, 03 Jun 2026 14:17:42 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b7a273e3sm59171155e9.0.2026.06.03.14.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 14:17:41 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: metze@samba.org
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
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu,  4 Jun 2026 00:17:36 +0300
Message-ID: <20260603211736.755139-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6518-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,gmail.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,samba.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF94563B5AC

Stefan Metzmacher <metze@samba.org>:
> Why is 'int fd' changed to 'unsigned long fd'?

Because preadv2 and pwritev2 take "unsigned long". I want vmsplice
to be as similar as possible to preadv2 and pwritev2.

> Should that be its own commit if the change is desired?

Yes, possibly. But this patchset already got to next.

-- 
Askar Safin

