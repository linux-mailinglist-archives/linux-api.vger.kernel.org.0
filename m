Return-Path: <linux-api+bounces-6478-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFTdKUf5HGplUgkAu9opvQ
	(envelope-from <linux-api+bounces-6478-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 05:15:19 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F09619266
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 05:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F3AA3019C84
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2026 03:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFAE25B093;
	Mon,  1 Jun 2026 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="Gr7Xked5"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE824A06A
	for <linux-api@vger.kernel.org>; Mon,  1 Jun 2026 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283510; cv=pass; b=OqrbpJWzRiGyGlW3xw8ye1FB3X/R5wsVW8esO2oulBvgsIxBBmGfc8eKJVxfL/obxcf4YzShZO9T3+fXhuOGNFHxqhoiaHZcCvHWcmgqr1lpqrbGA2c8RL29iXcojMxWiJur9LngApYK6cQespLOLMnjcJsYvWT68mu3yI12bqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283510; c=relaxed/simple;
	bh=3MMmkUu/YfzDJCqhb57EOJIut04O28w1bNQaD8zFkqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q62GkQPFZ+DYu/znyqyyHT91YhKUaNyNtGwMKKnyxn4zd7Ue57bd4zl6Vs8AdZAAkqTHvP/eWlNEw2r3eAJ1/uF/HuUy5wbsMqxf+ykFhlqU/V5akxjhUJIi0sf8JGJCoYTYrfyaPSq1KaooJvx+v7pOUObq0bk6M1Pe4sG4slU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Gr7Xked5; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa68dbb38aso643589e87.2
        for <linux-api@vger.kernel.org>; Sun, 31 May 2026 20:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780283507; cv=none;
        d=google.com; s=arc-20240605;
        b=WkdM8m5bC2bFYo1IiQ1/58AXj+B0bswWRAGgBoBfWC290G1o8ZJMi5khxeRs70RvkZ
         2Dzrtyl3JWEadE25JqZWZhfi+2B+E/11ddmZ4kwkNClkHU+Fzm5CNMS61fQg7NSrirUS
         O12zcV/uymqOdCMLLZ5QbylFWgTYe+jcgkliJCKX647tQm/Q3d5lH9QagAaf/nADhUsa
         T+Hh110G64wkINUdhIJtLp8a10Xn9LauMclZOi6/WwrwuPvQHbPZTvcaU93MWyMiWOMa
         vvbiq9KBiRDsqczgufZsCEZRlQEBHssJ9KLi0SkD2CU+lNoae8gYgOEzFiHOZhV6HVlN
         I2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MuDntok0/7oP3h0HaSkrbvB8I/WbSdzhW7ajx8MOkQs=;
        fh=9bC6XcVVGC5X86oAiQWb9zQJ4vv11w6vOABzt63bknw=;
        b=NBa+7wldnV5vcx3jIdR2PFQvBuB3DQ4N10K07iuKIT/K0Vk0U7Dk68LyAE9CsKrIW2
         qv75duXYH7RLg1XvZOGz9DyTfzq/hSYtujaKD7caRjNUE4DuIGVwF06tKqN22J+WsNCr
         XkjD8sgdGsOE28/xfB/wsLTW/kqNKFhGDapnLyRwIJudEFBgHMvKprTugFhuXhiYHJZV
         yutVqjWWKze4x7TzaBH0+7W+JXFJxgii1o3oGgYvJS/6HbnJwB073FxE97Vxuw9ykGq5
         aPFiSwAj6lIIDGP1AH8ANzVND0CjIDAqlpOFXkg6VGvO5d13M2aUgRxfEdzvWoa/h39S
         /7OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780283507; x=1780888307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuDntok0/7oP3h0HaSkrbvB8I/WbSdzhW7ajx8MOkQs=;
        b=Gr7Xked5yR/ormdg6QmBhuz2EBqlCzpWBE2BhBmhSBdzCgihYFsbieosgEIPjRtYD+
         ivgvFTq4CSNpUsUQfk5YijQ2OhavjVJCtbNEmPdBcxfYB4r9MB7bJxV7MMwh+DZYFFpp
         v759H90t+ReadfkRDLe8WQfybeejBFfb0QVybNh/KNGzJkgBDjsHezX+0TqVCNpe8DQi
         w26QmkJ70iQcFPCcXPGdm4trE8B6SImrK/2uvsMQS/OrXUflXJDvOdwAnd+cAtQ8Z9Ki
         vhTgzaJqws6ofLXjpCx3uynsdQnCr9TQ6rF2xezjyq2kL7Y/GZXQQvO721TkWqmtat6s
         WEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780283507; x=1780888307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MuDntok0/7oP3h0HaSkrbvB8I/WbSdzhW7ajx8MOkQs=;
        b=LtahN1aFye1Mpue1SMnIVDgIS9twmHjdYGXh3qR+EHPUNrS1hhzectaBq0jQgnVDeB
         IHlL2Nwi6rRc+AphvFX5IOksxlUVCsnrXIYBOEcgbLmPHbaXgVh1i/xAAl8nrYNw9Ujc
         5qlAtvwlLecpn+ldZREUeI/3tHo9OZ76NdgLVDx1FFK9D+OU4Og5Ii625G0c0gXTUTiz
         tTXDjChAJYeIN2RhnKBVX6k2nQSof4sqqcLUwBPmExKfrDYcC0ivs8K2FleRW4k/azO8
         zzlOo0u0YP0t0y3p18lYGs3Qmsd5UAVbbC/lQCjWGCwWPwlcP/rUEAiPg+t+nZVJ4TBB
         NzqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+DGsH2YdtyOUDk9CwlQXjiSU3jsIY2IhsBsqOzfupQGvODCPFje3b8vSD+Vy52GOO86LJW+Tt0GP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYh2UxHQwPLRIXg9COVUHfGt9nL+CM6a7TakkGaYkQTAPrjz4
	B5rUNtV2foUZsyfVIYMeQ7Da+IhU4+ip0DZQf/BhhRH0DtM5omnFnRG+mtRdgKT13pKFDC1xQEe
	IPtgW6ErhXuM4cmIJipps76MkIJuqI+nWeKuVnPmv
X-Gm-Gg: Acq92OH4SaBfFAUiVuLiHo/oGHQaZlF9DGTtcv9J5+vSZpPeIU4jigdKv3D8XaYqffA
	LTHrRnkucJcMGSDDOBS7y0Ppkd9X121FQdjbCoEOKzBPv06k0/WTb4HRKBE6cifZ7Bxcpb6YUE6
	0lBHIu1tMtGT0uKYoVTbDTYVEf6xTU+rNLTkJLmL5A1giidcWkrdGFJMwpMOqFjqZ/QHQycOP7x
	yqMxDbRhfP+Ijr2dzEuJbTSV5DeZPT1+539Gz8+SBDJrMMS3b0qTaFabAQsY3VAiIUEPjtKlosJ
	T/DUI7f/Kz69SWo=
X-Received: by 2002:a05:6512:158e:b0:5aa:690c:662f with SMTP id
 2adb3069b0e04-5aa690c66e9mr1347657e87.23.1780283506595; Sun, 31 May 2026
 20:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
In-Reply-To: <20260531010107.1953702-1-safinaskar@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 31 May 2026 20:11:34 -0700
X-Gm-Features: AVHnY4JXGlP1eBaFLieX9GEu2QC7fa8YTkX6sK3P-yG-Mx-u9DLHduWiKUrWdA8
Message-ID: <CALCETrW__=8mSusayfXG7UFCfue5BGbx+vqESj1d9wqOfX4s8w@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[amacapital.net];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6478-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,amacapital-net.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 20F09619266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 6:03=E2=80=AFPM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> See recent discussion here:
> https://lore.kernel.org/all/20260516182126.530498-1-pfalcato@suse.de/T/#u
>
> For all these reasons I propose to make vmsplice a simple wrapper for
> preadv2/pwritev2.
>

I have no comment on the code or the history.  But I'm 100% in favor
of the solution.  vmsplice is a crappy API, and would be incredibly
complex to get the implementation right,  and it should be removed.
But it has users, and the approach of just mapping them straight to
pread/pwrite makes perfect sense.

(If anyone wants to contemplate how bad the API is, contemplate gift
mode.  Or contemplate that, if you want correct results, you need to
avoid modifying the memory until the recipient is done reading or you
need to avoid reading the memory until the writer is done writing, and
vmsplice *does not tell you when it's done*.  And there isn't even a
caller specification of whether they want to read or write.  It's ...
crap.)

--Andy

