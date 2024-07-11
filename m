Return-Path: <linux-api+bounces-1928-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C268B92DF55
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 07:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F9DB21650
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 05:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CEE5821A;
	Thu, 11 Jul 2024 05:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LQy8RKob"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976F4EB55
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720674905; cv=none; b=cpe1Lk4tun7a9LVtecJLbB3HenMC3fP9ZWlhQ4DgTXUgF8cL/QY6zQ1u3NZynr2lKAN7D8sIgK9yQbtsGXIRd7UpcobIvwBrF7EPEKwtgiU9Ad8BzUTqFWa3uaLZBEnf/lJ2s8VDR2S0FSdplQ5tt8NBcj2zxpFJg2MZnxIYzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720674905; c=relaxed/simple;
	bh=nGrmC0u5rsERqyefhRnP7/QKTu/yo7p7qovzWnDCLCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hiu646sICUnG1I/rc4r070kkPupBw5+r5UPucC5cXlDv7OTEQ+AZKgsz4SDHTXnIHFlAQM5btXY0D8e1Z3ut8fGZ3cTF/M96ZrGgVE6VvDyGl3APGxnN6TLlzUYD8GanH6zeN6+ggD1ukS06R92CNaaZJF7235z3/X8XJvFALGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LQy8RKob; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea79e689eso648728e87.1
        for <linux-api@vger.kernel.org>; Wed, 10 Jul 2024 22:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720674901; x=1721279701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jtRyIrmKJ/IBvDIrDZPP2KUo8CcYvxcVDEjZhvnGRqk=;
        b=LQy8RKobEGS4wOxjuJjAlLoZrxMw8LRxOYEx75AW+Eu1qd7pdNRjQNtpHNs0pcFz90
         3wnyFCC+4cabzWRuAhACc5KpME0ZQrA7f/va8MONanxofrKiYbhzGFvvh0PKuledpitB
         Y+mycBkQLynB/nWSFsOY2lyRVLt3WhB6zBNwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720674901; x=1721279701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtRyIrmKJ/IBvDIrDZPP2KUo8CcYvxcVDEjZhvnGRqk=;
        b=kTmNZ6mj++6+ah+IaUP8h5RB5CZP1NM+7Jgrdyis0+K2l8fkO9TUgjSJvD8+ydPP90
         ne+FZpz1vOt+u1DZ7PGXyx7+0EvFOxmrdBfF91GDtGNQuM4KVgbyCb6BbjeA0A2IP8fY
         bjend9SuPypVF2pKAsOPVdTzdj/Cj4dQK74NII7JVoFuxee2p6Ytx/HtBkb/NC8/ujt+
         c4QYTND4r5PzjB5rs0tDWxetMNA72VZl8gVdEcb7On7N+JN/ynB4CZjGNVku9h/2vPRP
         3bSGRl/WK3ZqlxP55VovCFbZnJtZ1IkuJaDOkJr+4QsU2jSVf+bEF6taYVbyQMejQKPp
         neqA==
X-Forwarded-Encrypted: i=1; AJvYcCVMQ/fWihoNb6jDlY3Ar9I5WMe3bIgdFlzfqGq/OiYzrUkCqsiaL5QxAPKEeJqolfybCl8XLtV/fDSha5tMeqV+aNJr9GAXEvu5
X-Gm-Message-State: AOJu0YyPwwehhl6+9zn5ecKE+Y5EvhQLegYYstHrS8OCz4vOrwYyEA0t
	VNm+lNH3anL4ThP5lF5zTXHyVBRS4/hK4QU9LaTQZoD50ogVEQIZJHYVrzBA+4/BanZIYarnFeh
	kluE=
X-Google-Smtp-Source: AGHT+IGKtcrLmV8BX4JSFPcIX9IlcM239v171oco9lKHkpt/J4ckLCf8bp7bBuoPQzpLMToTaz0hZw==
X-Received: by 2002:a05:6512:1110:b0:52c:d2ab:693a with SMTP id 2adb3069b0e04-52eb99d28c5mr6764126e87.54.1720674901030;
        Wed, 10 Jul 2024 22:15:01 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ffa13sm221000366b.129.2024.07.10.22.15.00
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 22:15:00 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so3348475e9.2
        for <linux-api@vger.kernel.org>; Wed, 10 Jul 2024 22:15:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhN/AMI3gRk4cNhX2t09h0F9R2iJtd3c+mDiIRIiwfmAf8vBqTI8cvgAhWVfxZOABhnP/tZJUgM8gdrQsOZxMawNKBNurcsweu
X-Received: by 2002:a05:6402:134f:b0:58d:77e0:5c29 with SMTP id
 4fb4d7f45d1cf-594bb181cb8mr5703709a12.10.1720674440224; Wed, 10 Jul 2024
 22:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709130513.98102-1-Jason@zx2c4.com> <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com> <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com> <Zo9gXAlF-82_EYX1@zx2c4.com> <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
In-Reply-To: <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jul 2024 22:07:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
Message-ID: <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: David Hildenbrand <david@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jul 2024 at 21:46, David Hildenbrand <david@redhat.com> wrote:
>
> Maybe we can find ways of simply never marking these pages dirty, so we
> don't have to special-case that code where we don't really have a VMA at
> hand?

That's one option. Jason's patch basically goes "ignore folio dirty
bit for these pages".

Your suggestion basically says "don't turn folios dirty in the first place".

It's mainly the pte_dirty games in mm/vmscan.c that does it
(walk_pte_range), but also the tear-down in mm/memory.c
(zap_present_folio_ptes). Possibly others that I didn't think of.

Both do have access to the vma, although in the case of
walk_pte_range() we don't actually pass it down because we haven't
needed it).

There's also page_vma_mkclean_one(), try_to_unmap_one() and
try_to_migrate_one().  And possibly many others I haven't even thought
about.

So quite a few places that do that "transfer dirty bit from pte to folio".

The other approach might be to just let all the dirty handling happen
- make droppable pages have a "page->mapping" (and not be anonymous),
and have the mapping->a_ops->writepage() just always return success
immediately.

That might actually be a conceptually simpler model. MAP_DROPPABLE
becomes a shared mapping that just has a really cheap writeback that
throws the data away. No need to worry about swap cache or anything
like that, because that's just for anonymous pages.

I say "conceptually simpler", because right now the patch does depend
on just using the regular anon page faulting etc code.

                 Linus

