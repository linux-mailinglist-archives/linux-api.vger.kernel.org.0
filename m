Return-Path: <linux-api+bounces-2124-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8701C94868E
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 02:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC528443A
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 00:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC7864A;
	Tue,  6 Aug 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LXwLv/Hn"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB6382
	for <linux-api@vger.kernel.org>; Tue,  6 Aug 2024 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722903235; cv=none; b=FcQ+MEqcGcE+GDIV0AALWayaThU6bzcvxzi5gj8aWiHIXahiU8nS+WzGGRxWUhaEYhajgw/UCbMtzQIE14CN7fl0/6ZYOcSBFK8uNM7RItszkjqwyxjE6haGB41S2h40gbVx+9AZsz2Ah9Dj0MdKN11t8Ul8PMEaDZpGZUYw+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722903235; c=relaxed/simple;
	bh=KhE7wem6k7+mMBHOIKFkuNlqunhQlQKQ2o5ffgZbY9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXvezz3R3HMSa0/NIm8m+hvoymtoEkILv2mW5CHvJEhAt2whuPXM1N3O8FehE+bsmE3x3zaweu6hRiRM2riQ3xPz3+1bxEvQxFS4IkGjoprojTN2rAWH/AH8JR6r3vY16/zZ1VyfUi13r53JYdqjgnnzQ9lNh3fubz/lbs1tD8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LXwLv/Hn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so45004a12.3
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 17:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722903231; x=1723508031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s/w/R50dzf1u4Y5vhvcxV6m9BvUcW7XkQaFxdwQ7Gmk=;
        b=LXwLv/Hng0qb2VxsdxUNhLAdnsChLufJ/2dzQq820fxBWenZw+ALjhunrTH98LDoU9
         2ZzhQ83N5mu7vh/ribkENHmSrXiSRHOgHBKZIue7RSHk1wxgmcGLnSY55f9Z5I/LpDLF
         rwxUBo17fbGtreKUaaYc9iCsUdhaoqWSYrFx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722903231; x=1723508031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/w/R50dzf1u4Y5vhvcxV6m9BvUcW7XkQaFxdwQ7Gmk=;
        b=QVI8ndqb/46KsCSrCB1dTW9dD1Id6ilFEp6RQTB9k3cN7ECEUoiASD0zEZn7rNtxAt
         C7aKCl2dihz1Fy+qDQR69Wuxns+Q5B/ISRiN6T05Yl7UTzM42/SAyN1vaLGY4NMsEh60
         todr2/dzibCM8tHJMRaI7obTVGA85qMmC6CxdMIU0MFrCDak+31EgD+bXmBoQMe/Vek6
         tGPAf+YuEpEFSIgdD1HEhXCTOURMqPhQaNHcSbog8DhYYMNel5l3t07KxtA68rSfjLHe
         TiXKZcIyUyOYq/8qGcIWS+Pj0/HB8hTaMqGo0lCZdbEpXFxzvd68vIXXAeoAujKYqjGe
         tbOg==
X-Forwarded-Encrypted: i=1; AJvYcCWlBj9PuqR9s3NikBxVfqQ/5n8sWZvEU9tap6S4+3gJH8aJWTw4jV4uKhajyT0NIkVwTuG74JY9qNLLanAEwEhZaKtkCCaIk5cb
X-Gm-Message-State: AOJu0YxEPWjcklGK4XcWTiJ/6H+K+64YBorAIZXB2ZKlMg3ixvSy36cd
	ghCdf99LS5VQB8qySzaGLdnziQbcK9h07XvJhStflxCmsOhmgzCfparm1IoA3e5nlcL+KCQSXCx
	SgVJhJg==
X-Google-Smtp-Source: AGHT+IE7M1OnxPRemmdatKbfJ790x2yfTx2umrVK4fbxqCn59yIljY5r0xIJ5R63Or995v8RAIke1A==
X-Received: by 2002:a17:906:d249:b0:a72:6055:788d with SMTP id a640c23a62f3a-a7dc506c5a1mr897556866b.42.1722903230963;
        Mon, 05 Aug 2024 17:13:50 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8dafsm500715166b.220.2024.08.05.17.13.50
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 17:13:50 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so44995a12.3
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 17:13:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXL+4QyJvxwF1dqK6ZG0LWrneRpWWpZy2pKzAICJG0HWucT4QHmIMz3D7GwExPQUVn5FVMxV1TWzZgerGV6K/7go3tczeb+5AFS
X-Received: by 2002:aa7:cd69:0:b0:58c:804a:6ee2 with SMTP id
 4fb4d7f45d1cf-5b7f4294a1emr9353286a12.20.1722903230289; Mon, 05 Aug 2024
 17:13:50 -0700 (PDT)
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
 <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
 <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com> <D38D6LJZOIQK.2GV58PGVL5K85@gmail.com>
In-Reply-To: <D38D6LJZOIQK.2GV58PGVL5K85@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 17:13:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
Message-ID: <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, Michael Ellerman <mpe@ellerman.id.au>, 
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

On Mon, 5 Aug 2024 at 16:25, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Can userspace on other archs not unmap their vdsos?

I think they can, and nobody cares. The "context.vdso" value stays at
some stale value, and anybody who tries to use it will just fail.

So what makes powerpc special is not "you can unmap the vdso", but
"powerpc cares".

I just don't quite know _why_ powerpc cares.

Judging by the comments and a quick 'grep', the reason may be

    arch/powerpc/perf/callchain_32.c

which seems to have some vdso knowledge.

But x86 does something kind of like that at signal frame generation
time, and doesn't care.

I really think it's an issue of "if you screw with the vdso, you get
to keep both broken pieces".

           Linus

