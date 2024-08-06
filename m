Return-Path: <linux-api+bounces-2135-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A50949408
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 17:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB480B28D0A
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 14:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15FE1D47D7;
	Tue,  6 Aug 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DCsBIddE"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58701C4630
	for <linux-api@vger.kernel.org>; Tue,  6 Aug 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955832; cv=none; b=ohu5fo+4Hq7I1jRiEm0JLg1Ek8tgWwGaNld+UytIvBWEYOndyXH3CEoPqAPiguL7bHWialQkVRJ3T8yK6xgKvNXUnhsGnb4XVQ8LdPprF2u2ozPBn75nGberVUIkBRtMnV5hU5MHOGnj6++ix6qW+JlvrHpkM9dvQv4uxp6kS6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955832; c=relaxed/simple;
	bh=cCHKtmZMWG5EuRXdTg7nfVOF5FzmMBB79fIHhpEkj/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYOZDfBfSTJb6UVc1mPDIQctbw7nKOBQxfXSzHDpSWV8UTGdVZgO3+MxOgP5SJWJ3zDaRmVpfbCxqfNkuVHrgC26ijFDQKBS4DTZy8Cv/I6T5bVYLxXjD8Au9w8OmupoT29vN6zKUa6HtZfGH5S3VlfCd5n+qp+OlnLb9gqNbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DCsBIddE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so76138066b.1
        for <linux-api@vger.kernel.org>; Tue, 06 Aug 2024 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722955829; x=1723560629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V1nh4YKkk4IMpcnlyRV2vMP/rs/wYu0mGINEfgtlYvY=;
        b=DCsBIddE7HdSwKtBDGylN0BQo8bTKs2v0GB4PrM0MTv30nPihkVAt/K0zzlikrvDHE
         IZcTOTnV1XrUSepmIBwOzwh/1eoMaWAOx8PdgRkn56YVW9pqsHORUfy49Dj5mYWjQaEC
         gug/WNDgfnzjTxADKo5qNIx0xH+Ep/04oEeNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955829; x=1723560629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1nh4YKkk4IMpcnlyRV2vMP/rs/wYu0mGINEfgtlYvY=;
        b=dHZF/VJBF20k8AcXpTuwxn5EwROcd7ATCqc+Wf/kjPf5qy5pSMjSl43eYA2dAUSlrs
         VlbYYXZwtEQQ6QCwW+H/ozPPkjkEBaQ81UAeG1NisCqtgz5v63g3ZEJRR9gmv20g0rA3
         1v1LjPei9Eerg4PIpKc6kR0SaD/g+K4lQC/JsbtvfjyA3vNPiU5Rg+7B/wdl/jsvLBaw
         TElHjeNyExCSBpLCogfGne9XPLTx6LqxSn82FugZKwhQK9yWl9TwJwRxcmMg0NAml1XB
         cv9E7+Z+EFzIZLXbuM7FlmKaKByE2CfXbX2Fk/b3nPtreACxKbxHQ7rgU4qnrgjRtD+2
         kRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSIuw2cPjJAOu4w13dGskb3ycytRVgZf6laJR+yotDE1IhII+uCkoW9TEVLUoB1nkwiT8614Imqv8gwAMJCXF473IEO1Tj3bjb
X-Gm-Message-State: AOJu0Yyz4Gvpypwm0Pgq0pnZBc9x9zWsKcfiYFKmEv+3uB7cjMBCiT/q
	jhy2EqiFEBR2W+qlenouHIMzbrrpVrhmOecNNk5FEpESum/V7dWErDx0iWPbXEW+qDBI9c0Q5kr
	kwEK99A==
X-Google-Smtp-Source: AGHT+IGHYZdroaRkAOn+LA+/Y2CyuAxWnpQployxFTtPkBG/vTp03L9DERXaPoM2hKms8iQLJa84TA==
X-Received: by 2002:a17:907:724b:b0:a77:eb34:3b4b with SMTP id a640c23a62f3a-a7dc4dc02a3mr1228684866b.11.1722955829048;
        Tue, 06 Aug 2024 07:50:29 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83ec1sm553705666b.182.2024.08.06.07.50.28
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 07:50:28 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so5259255e9.2
        for <linux-api@vger.kernel.org>; Tue, 06 Aug 2024 07:50:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVzY9c5OkCG/96aU4GAiUoeAiajDnUihlj1QbRhT9ApmJxPN0QETxlWRY7wIC6nzVBN9NJ6/i6VCL710gGuuyU7Kg2V2/8q07Q
X-Received: by 2002:a05:6402:c08:b0:5b9:3846:8bab with SMTP id
 4fb4d7f45d1cf-5b938469427mr8541227a12.14.1722955431683; Tue, 06 Aug 2024
 07:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com>
 <87o766iehy.fsf@mail.lhotse> <CAHk-=whQwJaS=jVWVvvvf0R=45EGMb0itmhhSpa7_xWJXQY71Q@mail.gmail.com>
 <87bk25j1sx.fsf@mail.lhotse>
In-Reply-To: <87bk25j1sx.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 07:43:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQ4x+ZgG7txteY70fvmHkuvRstMZj06XscmKfDL+RBCg@mail.gmail.com>
Message-ID: <CAHk-=whQ4x+ZgG7txteY70fvmHkuvRstMZj06XscmKfDL+RBCg@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jeff Xu <jeffxu@google.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 05:03, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Or should I turn it into a series and post it?

I think post it as a single working patch rather than as a series that
breaks things and then fixes it.

And considering that you did all the testing and found the problems,
just take ownership of it and make it a "Suggested-by: Linus" or
something.

That's what my original patch was anyway: "something like this".

            Linus

