Return-Path: <linux-api+bounces-6673-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1UuNC7jsPGr8uQgAu9opvQ
	(envelope-from <linux-api+bounces-6673-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:54:16 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213C36C3FDA
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:54:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TeZSIzER;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6673-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6673-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D0D73006092
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 08:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C982385D88;
	Thu, 25 Jun 2026 08:54:11 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA487386C18
	for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 08:54:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377651; cv=none; b=HPmSebF8QVdyycF2KZSm/eGLKGPkT6JRnQmou431NWmsKSz2JBj1Kb71VVAWmOgjCjZV9nPbGoNRL/2IxYv1WUH38Nq/HBK+2cASDXyNqQqHh3fPb4NjISv4FXBekqKa4hz5AWJF8XUAe6bQKEw9ZL0RRALQaTP4+kCsrnpJ+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377651; c=relaxed/simple;
	bh=07Gz4DVxSchKBz41aocKqPwLf5Q7wYxmqWLTrZ9H6nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1y9TtBAICVvjHcaMOS9GPkuHi8r2kgpZ16Vure9cWj9jAsDxMqqk7N/s0vk84JOA0NdgHrpyEsizRG7Xr0qCVkKo3+1O5GvHOUqHOyGPGECcXeqvfyXfnJds0hhbOrYLCyjDXCa8NtB7LbcSTceu17UPEfyut88izhaQ9t5OIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeZSIzER; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46e30429b10so64266f8f.1
        for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782377648; x=1782982448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jDoMmJJU0PpNgF+w3Xx9Gr+Xmtdk7u64RSrEr55CTg=;
        b=TeZSIzEROk+wXDUJ2H7J9qtITFj/majCzC4RRZwR633P94dRl4K2X4xiaAK7By7ze+
         K7DEGTJXoevUXfACUrh94xn6QJW/a9k6IusZA+lUxNCYXYF8S42eYkontmM4rq0Na2aQ
         VAdzE3UF3hq9AN3CidWOXPvSKb8xj/JDx7dUSbkR9TK0a4z59WyHTnjeoB6VqCsbWJCd
         waHDjV9/lCOJFuenJhABaW6KNlKJAQTtgSEFSccoL/kpVwQ5UPfl1w/boO/W8vAonLkh
         N+SyAwoJJ5z6KfqBhkwIIquIKvHtokZto2zPXoQgTZiVHXJCs0z+izxUUJ24lECJRKpq
         ljPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377648; x=1782982448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jDoMmJJU0PpNgF+w3Xx9Gr+Xmtdk7u64RSrEr55CTg=;
        b=Pr1rHfj3dYq1AojrwpwQ8CqCMwInIZTV7xJDRrPfK/uisZpG5+aavgSQuz8kcoPp0y
         gtyvZ0gz6d24w9Vn/Ax0YG043Fx8okK2Sd0R5asSrFQrAO8yCMjLAe+vuB0Zlc5Zdc5z
         AxWJ7MgcKarYpkFE56yyxonWK5shFkDaE+EoznDd940qowsE00/BLYRbtXzpafe+Pt8J
         Eg2OKBDk+c9C9BtIVFfI14e1DwiSU+CoedJfYksNYs6rmdBe2wbHu5V/vHDS4pCo8VyN
         AGkjoETFUjcffA46VkbUuNc1LVasFTj7WUWNux/H45XodkflVtytMByXAHjQsBHmbgRn
         niYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4H9RdLlZ3U+YbNklR4i3SBhOet8simSRTxjttToKw7DkL9xdlw7OCoheo02P3aflCTeKXHKbMz1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZzFKKxswlzoD+M66CKKTCRL5bZo4ZdkNunilYX2kBV3QmqNxe
	Yy/svTQ6/frWZKaDIftWJJqDtFT02ixIX87Wh1Vf9MRonv7Ds6jrrnwA
X-Gm-Gg: AfdE7clhhKWRWECi7KAQTMnCrrEM7k5HWQK9BBD9zUlXCJf5ddEuuHDkZTTU+oL4xb2
	DsstZfFwnChTZWtEzcTlk9kj2qh4hB5ij9RhujfXeio6Pc8yYnGvWPuWxxYfzYjOLrsIyVOnO/9
	KR+iIOQQoUfJBUQg1MRkp8RRUbElblBcmRlyt9To6SRQ67tUOxXyoCQuvYYNL/isxbGAblEaeYG
	sOKj26VUtoy+bfNE9k/PFG1CVJqSTyOH8IFU5w4aR4u32GCK18O0vAS40vBINFddf35sKclvnjc
	gwKnWbBG8px/sw2I1rpBt7Y2jZQM0F2uXm60mzTrBvlrjhYpwDYBUtdy7pHhQmOzH2l3iXG5rh9
	ge5LpvGF89XORsl15rpDj41L5DMTbJqtWHHMxBjoCqr8Q4JXzx6bZYPimR894h2zqy7/vR3688U
	tGDBFNSAKD
X-Received: by 2002:a5d:64e4:0:b0:460:67b7:54f1 with SMTP id ffacd0b85a97d-46dc30e2c21mr2268492f8f.42.1782377648254;
        Thu, 25 Jun 2026 01:54:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c1ee018e8sm15530598f8f.11.2026.06.25.01.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:54:07 -0700 (PDT)
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
Date: Thu, 25 Jun 2026 11:53:57 +0300
Message-ID: <20260625085401.3787887-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANaxB-xUrLQYGiRJZc4Boi+KX=0TJSWymErNovANVko20fMDVA@mail.gmail.com>
References: <CANaxB-xUrLQYGiRJZc4Boi+KX=0TJSWymErNovANVko20fMDVA@mail.gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6673-lists,linux-api=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_RECIPIENTS(0.00)[m:avagin@gmail.com,m:akpm@linux-foundation.org,m:alexander@mihalicyn.com,m:axboe@kernel.dk,m:bernd@bsbernd.com,m:brauner@kernel.org,m:criu@lists.linux.dev,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,mihalicyn.com,kernel.dk,bsbernd.com,kernel.org,lists.linux.dev,redhat.com,infradead.org,suse.cz,gmail.com,vger.kernel.org,kvack.org,szeredi.hu,suse.de,goodmis.org,packett.cool,zeniv.linux.org.uk];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 213C36C3FDA

Andrei Vagin <avagin@gmail.com>:
> On Wed, Jun 24, 2026 at 12:12 AM Askar Safin <safinaskar@gmail.com> wrote:
> > Does CRIU actually rely on ability to do SPLICE_F_NONBLOCK vmsplice into
> > named fifos? Or this is merely a test?
> 
> Yes, it does.

I. e. CRIU relies on that named fifo behavior? Okay, I just sent
v2 version of my fixes. The patchset contains fix for named fifos.

Please, test that this fixes that named fifo problem.

> I already explained that this isn't just a perfomance degradation, it
> actually breaks the pre-dump mechanism in CRIU. vmsplice is invoked from
> our parasite code within the context of a user process, where execution
> speed is critical. A heavy performance penalty completely invalidates
> the pre-dump logic, making the feature useless.

This is very unfortunate. But I still want to remove vmsplice.

> At a minimum, we may need to consider a deprecation plan where vmsplice
> with SPLICE_F_GIFT triggers a warning for a few releases before these
> changes are applied. Alternatively, we could introduce the proposed
> behavior alongside a sysctl to fall back to the old behavior and explicitly
> state that this fallback path will be completely deprecated in a future kernel
> version.

My patches change not only SPLICE_F_GIFT behavior, but also vmsplice
behavior in general.

Let other developers decide what to do (i. e. do nothing, remove
vmsplice now or implement some deprecation scheme).

-- 
Askar Safin

