Return-Path: <linux-api+bounces-6484-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMmPKVa1HWrKdAkAu9opvQ
	(envelope-from <linux-api+bounces-6484-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 18:37:42 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1562B622A9C
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 18:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A958030EDE80
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2026 16:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01EC2E8DEA;
	Mon,  1 Jun 2026 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I/MPEzgq"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443272DCBF4
	for <linux-api@vger.kernel.org>; Mon,  1 Jun 2026 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330996; cv=none; b=sMwruXZ9ptPuulQUa7o5vFgiaVmHgRhtdAxdbx8HmWgXi/A1sBGdNNUM5xuzqXgY3c7p4NxQyeKXTwlSA+k0R5J3mnSKgO1ZQvvDppST+1nT3VhN+uWRdaA0yg27+x5ll/AJRXwqiOblZ8YKpptvap/aM0QVq4nftUZRam8Rlhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330996; c=relaxed/simple;
	bh=JHA8A2LqDoxqFwpttDeYSscr29A5V44SjxGPurj2m8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTKNVXR6tcm1wsEPY6HOmlV0BUeeXED9/HxXtvyhRM238EwckjAvltLHjthBHzLYJP31zX+8wZSvsWyI1K4FC6dIj+p9atwntPhDfrY2RnSC6Q0guSYwE3I6UIImXZJL0C5WDiCSUtGpgTbpSjUiQjJR46rGMeNAF46i+tlP0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I/MPEzgq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6896c54a7easo9860283a12.3
        for <linux-api@vger.kernel.org>; Mon, 01 Jun 2026 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780330994; x=1780935794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K5aZ4vAk82i6DVnbVmOCwCzllylMU3ucK3p4smWm5Ow=;
        b=I/MPEzgqZd5kf1mBDFNckJQJAuhncf370q2axwNgJrMpqJBzefy0Vi4VxsykHPracJ
         8hEt3umnbUADFtiT6Kwe5v5JU6TlS3HopnbF99D+Gkv24iX2PQW+fWwa0FLQzWFDYI3t
         YDF7P2d5ncaUXvDVJ8U82puYzkpy9PJcjzy78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780330994; x=1780935794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5aZ4vAk82i6DVnbVmOCwCzllylMU3ucK3p4smWm5Ow=;
        b=BwpU57AtjUiDboQO3URJHtrpEaQS3gIHMV+61nXMhQXS9nhWc0PSkR/risPSaVtde5
         Uvq2L3QlTnPx23rdR/Sr/d5ppfohEhaq77tKmKS4PIJ4mPKoCjomMmwkKaXBlfqeS9lY
         cWv9X6xNh40VQ4Nl7msysJwcojYmIqbg55G8diLybYFZ3zw1Pl70JyH4ECARNLWLgkXs
         mUdpUDv2XesKkBi/nzhZ3feGEkrjJpguBRWC14BvsJNlOkil6vM2e4ceLw7henXmjn0m
         azwAY9oNNwfdaNqDGIM4ffXgSHz8uSNVEf0THe4TtyrO+oDxWUt82EgEABf4P77Ss4As
         flUg==
X-Forwarded-Encrypted: i=1; AFNElJ+93DQv/pqubWIrmVvkTjAyxDpD2cJBCY8jFBafVQlFEucAXdlWw5kRFjvlbrd+ayHIpMm0NjyxiRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+oWJAnBUA3edqpnR0TcjfA8IGVo+faYX/bK3K686cFeMP6hdh
	i0Ay0WyGeNZjiibS9BJxWK1kBpQ0hbub/T99wztn84/WditKKsxCSYHpa/hChG59CBn10K8Z/FY
	nzXKsrTI=
X-Gm-Gg: Acq92OGkD1X3jQ2o3xJY5fR3B6jWuYLECAcSAfOGqmLVOKbCApq98NOozRILWAvejp9
	uYHY19ITgTqVY072Hjlwl77vQwSf65/LfmWSHIhxbjUmL/CXkHKHuHDemAIX422pLuZXREiRpOz
	e+93zB9UkCckgocEs2QTkeYUxCW5lx+P6HhdwoQnnyEaRf6KyQuwTUnC52FluQuQnWvBoC1Jxfh
	T9IR78jlYaakoa5aaX5c3MP3sMIvDRcGGr1kpeOrFyYQENJBh7mIwHxuMjwVCZ59Ta78fOXcd8W
	7GiOZj8Mxby2spTGIVvD9Z4gDIrBrBtn7HzaSXdOLkbXhWqRVkmtFf1uyZUIfWvW4hfbHtaJozr
	JXQx5MZ2nszdPWlx64TJq3Ct78u2VOmKYvQ7EpzAJdqy7ei6UefwHZfe+eYHaKfHk8MhQh44HVL
	EpEVIKu2SSvaAPtnFYm5vPQD5U0fVRincJXdwibWvo6jpOI3vdnAoBrKpxj5ZSwUMReZz41+kBX
	StsDZbkyVM=
X-Received: by 2002:a17:907:7351:b0:beb:a431:6750 with SMTP id a640c23a62f3a-beba4316bd4mr387519266b.29.1780330993563;
        Mon, 01 Jun 2026 09:23:13 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d69cb416sm366414866b.57.2026.06.01.09.23.12
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 09:23:13 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bebde89cfd3so240070766b.2
        for <linux-api@vger.kernel.org>; Mon, 01 Jun 2026 09:23:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+9AKkIGZsXnqpeS/CuJdXvMVfAt0/N+93hH6Q4pn7CjM2+cKDQKZFiXWR2Mixbw7ewNcOn5BWMriA=@vger.kernel.org
X-Received: by 2002:a17:907:3d45:b0:be3:b3fb:e2 with SMTP id
 a640c23a62f3a-beab207a691mr724400066b.32.1780330992765; Mon, 01 Jun 2026
 09:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <CALCETrW__=8mSusayfXG7UFCfue5BGbx+vqESj1d9wqOfX4s8w@mail.gmail.com>
 <ah2nBAdsE5vVJ2PL@casper.infradead.org> <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
 <20260601-aufweichen-dissens-ausrechnen-0d9b84728113@brauner>
In-Reply-To: <20260601-aufweichen-dissens-ausrechnen-0d9b84728113@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jun 2026 09:22:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1dSKpF=NMJmm9d-7kJY=BEVkchTaxsL1LGL3n89KtBg@mail.gmail.com>
X-Gm-Features: AVHnY4Kn-EiKMLw7r2InJ00RsvMx_ZNQz4aALUAoaty1wqi8l1c2ToY4hj4PgVo
Message-ID: <CAHk-=wj1dSKpF=NMJmm9d-7kJY=BEVkchTaxsL1LGL3n89KtBg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andy Lutomirski <luto@amacapital.net>, 
	Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6484-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,amacapital.net,gmail.com,vger.kernel.org,zeniv.linux.org.uk,suse.cz,kvack.org,kernel.dk,redhat.com,linux-foundation.org,kernel.org,suse.de,szeredi.hu,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-foundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1562B622A9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 at 09:17, Christian Brauner <brauner@kernel.org> wrote:
>
> As usual I would argue to accept it and revert in case we get actual
> regression reports...

Yes, likely the only way we'd ever find out ..

          Linus

