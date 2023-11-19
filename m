Return-Path: <linux-api+bounces-87-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8759E7F06F8
	for <lists+linux-api@lfdr.de>; Sun, 19 Nov 2023 15:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78B11C203B7
	for <lists+linux-api@lfdr.de>; Sun, 19 Nov 2023 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DCC1875;
	Sun, 19 Nov 2023 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkYRGAZY"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFEAE1;
	Sun, 19 Nov 2023 06:54:43 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28035cf6a30so2722483a91.3;
        Sun, 19 Nov 2023 06:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700405683; x=1701010483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UFViZfi+D4ykbhkIT1nTXXcFAxgIUhFWAUIBpe5r3Wc=;
        b=ZkYRGAZY1eqCGhzjf/MmU0AdLwn1Qe9xCD76KdWY3zEnj2KO6KYSjOkYMtgQWfyk84
         +g+zHJwGzNUDPjKMYSAG8zO021qd12ZgtRU5Qm7FC1r99+74dckHxwfutRFKEgVqLS2q
         VjLGJp3kWyzO/X1p4g+xfqBj126TjrGX4SKTV7lQt1khTCiB4MSVrf+APOxS+7Rajnzy
         9d2Gnz40RhWIEWpjcvqYKT6f1MYr3SGDRUcaMJTg1a/kdVgq8jk0NxhtwmTvAbsNsZ79
         E52eWzxumClV3RdDXH0eZuXtvnNQ/IqwNWdiCisOyiqG1IHAxuKoW84ZIoYwwi+MG9Re
         SzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700405683; x=1701010483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFViZfi+D4ykbhkIT1nTXXcFAxgIUhFWAUIBpe5r3Wc=;
        b=myc+Cbwdg8hBQJ1p6BH0ORXZ8rZfV1NHHL5a50Y1r13kjU8PJ8CXaLPamDBQRnXTw7
         4uRwVXagJmbHLuPJ7iW0tfNMJgAMETNGuIxKHlbngMTg/d7kZx3/UZhf7l/FXiUpOHgV
         FfFv6ekPOheDJ7b1OAyFD/3Nki+bzSg8s3NgHw5az7EmsXKi9WyDk+++cBtKdbuO4woH
         b26S0Tn7g25/7aMVw94IjhUC+KxRi2JCUttHRKoDWeXgSthQNBNvS5zzDPaKgx/sH5Mf
         JhqAbKK82u6oNKkedI6WiNraDjL0s50+q4eOo/4pd0A2bB4cla3zOyK571x8GHWCQ27N
         /Puw==
X-Gm-Message-State: AOJu0Yxv89WAhACP7udQiFSP5OGR8Z7wIJxyWjTaAKJi95kWOFSD+0ea
	KIqa5nm+Xoph2U6CngJbYZ/R7cUdzLLzFUSYgSE=
X-Google-Smtp-Source: AGHT+IH+vd8OYZwpc2tfLC50gM6zOidWteKbkUKAokaglhsxOIquzqcPn2ooow/qdYCB+TyXuHNctw6hbmvYNqeRlzU=
X-Received: by 2002:a17:90a:1690:b0:281:416e:1c3f with SMTP id
 o16-20020a17090a169000b00281416e1c3fmr3470474pja.28.1700405683271; Sun, 19
 Nov 2023 06:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
 <20231111132431.GA3717@1wt.eu> <20231112045217.GA39417@mit.edu> <87fa3d2e-6822-0f24-daec-772dbe717b63@suse.cz>
In-Reply-To: <87fa3d2e-6822-0f24-daec-772dbe717b63@suse.cz>
From: Jasper Niebuhr <yjnworkstation@gmail.com>
Date: Sun, 19 Nov 2023 15:54:31 +0100
Message-ID: <CAMjCObsNOMxe52XT6L4JscX5VBO8xAjqjHy-bzRyoLU54G9gRA@mail.gmail.com>
Subject: Re: [PATCH] exitz syscall
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

I took some time to consider a few options...

1. MLOCK_ZERO_ON_FREE flag for mlock2:

This would achieve what I was looking for. On the other hand, this
feature could not be used to just ensure the memory is zeroed before
reallocation, without locking it to memory. So if you just want a few
regions to be protected from other processes, this would not be ideal.
Also the VM_* flags are all used otherwise (except for a random hole
in the middle).

2. PR_INIT_ON_FREE option for prctl + some cap against DoS:

This could, more generally, be used to "replace" other ways of
choosing initialization behavior. Systems could run with zeroing in
general disabled to improve performance and just use this feature
whenever needed. However, it seems counterintuitive to me to have a
prctl option to set properties of a range of memory. Is there a system
call to set general properties of memory areas?

3. CONFIG_MLOCK_INIT_ON_FREE:

Such a config could be used as an alternative to init_on_free (or its
DEFAULT_ON config) and would be limited to the much smaller amount of
mlocked memory. Again, this could not be used if you didn't want to
lock the pages to memory, but would definitely be one of the easiest
ways to avoid most of the init_on_free overhead with essentially the
same security.

4. PR_INIT_MLOCKED_ON_FREE option for prctl:

This would essentially be option 3. but even further limited to only
the processes that want it and cannot ensure keys are zeroed before an
exit/crash. This prctl option would take no further options except an
enable/disable switch. It could be called once, in the beginning, to
enable the feature. If the process then crashes, any mlocked memory is
cleared and does not make its way to another process. After any key
material has been erased, the program could call prctl again to
disable the feature so no clearing is done when the process exits.

Currently #1, #3 and #4 sound most applicable to me. Options #3 and #4
are probably a lot cleaner to implement, #1 and #4 should be more
performant. From your experience, how often would someone want to
seriously prevent memory from getting to another process without the
option to mlock it?

Is there any arguments I am missing? What's your opinion on these?
Which, if any, do you think would work best?

