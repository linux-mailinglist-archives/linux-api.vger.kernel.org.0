Return-Path: <linux-api+bounces-6532-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r9jRL0BDIWq7CAEAu9opvQ
	(envelope-from <linux-api+bounces-6532-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 11:20:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E7663E76D
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 11:19:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Z4Qk/eMs";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6532-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6532-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08CEE30344CA
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1D23FB070;
	Thu,  4 Jun 2026 09:06:14 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6D3FB7F3
	for <linux-api@vger.kernel.org>; Thu,  4 Jun 2026 09:06:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563974; cv=none; b=qJUXrasGjedug65WhteIEmGMNWt4MW0XfNdGElXgbML5dXSqaW2Kf/XICZNdBb+ldNwkqqv45zb+YLI3HtilQY7iZKTC+iMrpZYvQyadhsokFs1JczKuenoG4inCabBMenmIOwp5R6daVHZmMB3Jlvq3wHu1MCILjej+w598tZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563974; c=relaxed/simple;
	bh=6nC4qMmpp4fUyVsAFDYujq7+sxNujf5CGEPAWJHIlFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKEniNDDVFmEv4xpjSUt2r7Z3MwPXdFpcPbXmg935mGsTjApdJcKqYt3/0nuyG3SK5VuOq5DQO8AXCpnwQOm+o2kpUJSIJjKeMvKI6EYI5DsGd/oIoFp/Oppp29yMIVUTQdn35pwho1Mw9+J1P22Oa5U8ty0+HfT27CASrM3+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4Qk/eMs; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490af320e2aso5374375e9.2
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780563972; x=1781168772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdFuwsES54dFvGT6zPCTaZ+yF4K8AlHGY+rBuqBIdh4=;
        b=Z4Qk/eMsRQn5NaOl5EnL49h5mkIDXCd6CVB06Y3pkNHIQBrrOz07RC4i9WNJ7soZ5V
         ZwZnlbdEhstvH16TCDK3NLc3IDK022X024ITEBaBP7leRrZPYvIKM0a2oZgI8eLPi4hf
         l6bUS8EAAbKpENkoLhJlvpJaE3SPEuYNQtAyuGwu5GFaav3z27CJASM9RViLgvZnE9iX
         HnaGV4X3VncpchGb6vO7ALPLhi36EY0JNacWYHGwLG7HcXBXRzq/C0S0jLJRDSq+IYgB
         Ameqbmz9JWPN6B5sTwrZ27N7L7FPN5xbYHLpuQPyHE4EtAIwP41vpiRcH1y53BQ25zuc
         Uo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780563972; x=1781168772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EdFuwsES54dFvGT6zPCTaZ+yF4K8AlHGY+rBuqBIdh4=;
        b=doaay0WImT/t8IY50YJM4M5oDsIY1zyWkPnJ64ZSawzkLhPGGkIvLqNBv+yO9H7bcI
         uy6Si+IIPwqSmIVBVbFwrGB4OnNmnSTzn+hGOD3L0BzZ8lDtek4fXAtOio9rrYv65T5f
         X+K6n9S3c+BKReO/rbGTNFusnmhSErc0aMjQsW7KcTxIAVRTkvVHIkzeoCYkXOa8CTmZ
         NQpFEmA4In2jgr9XNCvHRASA4TkLEz7v9YzGqsUpdi7DXGakTo0+DdQDe61Zkd+QXW9r
         qRpL3ovk1so7HA1KS6Cdsfvw2KsObdMIebmEY7WN830l4FpnF1a43g+Nb+7yPit30F3P
         SPyg==
X-Forwarded-Encrypted: i=1; AFNElJ8QevJAE3M4ygT3ujG0LKjd28BIXzDDJ+LIW0J7SIp8bwz3RQSxAfwgHd6hvmYZAnPa03iq8A5M4/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGANmRth/5HqrzOfpYV21DyQv0eOpPGRTqTGnlD5PSnVoZow1
	3yb30/s8cOS9CByf9hC/ju7GG1SwSdrz0urp6oQ/6sEx1QP6zfr+s85r
X-Gm-Gg: Acq92OHDyqHAHaZIWPjILotChUqt06SdpcRkZOao1rqYPKNhNnFG2CCi6XlJxfHt35E
	ZBuGyZ4L0kyKbpHGe0HgH+0wt6JeObhFbWcxjl1BnnsTsm/k0Wprg+YmL8IMBDQ/r1TkXq9NW8F
	UrYr50o0rvNTJI2yPMYgUIz8nFZcFPNd6um3TLuy/9QblHLiP6AgcDhLYi9AWV0tWwB+h4KgEdW
	TZGkQ090gdYvpvU6V5O9NJUuG4/sIF6wKmkjY3QIjhyGVltgIeIvB3C0nLA6/OJxU57KM/9VckQ
	UptsW0j+LC208OIb3p7mZhQ8/LQAGHwwQfdMbmE9LZYDnYrGnG0n8jubONpAwnyfAxkGAXy3/dD
	NrE9GS29R//Ae6TltwtfIiOsA/umtPZrO0v3/X8qzsv050J7BVg5sgU/iLD0hIoUEaGItzb/kuv
	i/aa39wWvZQdw1tqD5PAg1G2I8c8UPdpqMF/Cs0yIrYKoejWP2x0n+o+UUg0H5jcryCGFjRjJiQ
	Jlb+uFk5A==
X-Received: by 2002:a05:600c:8184:b0:490:5cd8:d213 with SMTP id 5b1f17b1804b1-490b5eb44f8mr113527135e9.15.1780563971711;
        Thu, 04 Jun 2026 02:06:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7e6c774sm70203515e9.1.2026.06.04.02.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:06:11 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:06:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: metze@samba.org, akpm@linux-foundation.org, axboe@kernel.dk,
 brauner@kernel.org, david@kernel.org, dhowells@redhat.com,
 hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
 patches@lists.linux.dev, pfalcato@suse.de, torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260604100609.6b37f500@pumpkin>
In-Reply-To: <20260603211736.755139-1-safinaskar@gmail.com>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6532-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,samba.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9E7663E76D

On Thu,  4 Jun 2026 00:17:36 +0300
Askar Safin <safinaskar@gmail.com> wrote:

> Stefan Metzmacher <metze@samba.org>:
> > Why is 'int fd' changed to 'unsigned long fd'?  
> 
> Because preadv2 and pwritev2 take "unsigned long". I want vmsplice
> to be as similar as possible to preadv2 and pwritev2.

Something needs to ensure that the high 32bits of the fd get masked off
on 64bit systems.
They can be non-zero in the register that comes from userspace.

-- David

> 
> > Should that be its own commit if the change is desired?  
> 
> Yes, possibly. But this patchset already got to next.
> 


