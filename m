Return-Path: <linux-api+bounces-4288-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DEEB1A33E
	for <lists+linux-api@lfdr.de>; Mon,  4 Aug 2025 15:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D4B3A72AB
	for <lists+linux-api@lfdr.de>; Mon,  4 Aug 2025 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B461526A1A4;
	Mon,  4 Aug 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="T4ML8oWn"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B03525B687
	for <linux-api@vger.kernel.org>; Mon,  4 Aug 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314243; cv=none; b=r90367bM0B/7Sx8ka7J28XJi3p2g5KDIK/5uavH6KC9ErtzN3ww4b21+LSB4y7gtI9SCJKEJRB8vp88PqLvUdwxRGgpM/GsbT7cpFCT5h59dDlEnbtz1YMKiHtHKHRW3cCNItOnzMKKBZnXPEEqYUQl1l+0yfv9FoSIQZ4dLiN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314243; c=relaxed/simple;
	bh=bFoOwfkzpdGbVKg/8VjkthkcsGob+US83lQ5IAa++NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgB3rEJWxS8cXZeUlUDRe96qn4hBi0MAoePDh3VqftkmuvaGJ3O/ngEx6Pyq9Z19VFBqGw2URV2PsEbp8WSL4P0ePM5geDGWtwZUgiIK+d6adAw642hWgzybde+FqTVYBPR3kyB6A3k9IBvllNmrU5y+H3kgQ+HQ7fjOIqmMbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=T4ML8oWn; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4af1c1b5b38so16921691cf.1
        for <linux-api@vger.kernel.org>; Mon, 04 Aug 2025 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754314240; x=1754919040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P0DEJm4ykl78MCkCCnUIUGLbm0eW648bU8lzZM6Zg7k=;
        b=T4ML8oWnUOXuDeBLEJvjW4iRG+zgzlVQq8m/43KFn4jcCQPPtpRKhNNHh88UZfprJ5
         UYxtX/49E4azbMn+TG4EVCZwYch2V/cAyiFsFs0k+O2OGJXrMMwS2NFBoZ+HIofXA9kT
         QDxGRC8IMsDw+KNsMc49kEvHOzJCZKxkwBrCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754314240; x=1754919040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0DEJm4ykl78MCkCCnUIUGLbm0eW648bU8lzZM6Zg7k=;
        b=O0hh4rK5Oh0MIvTgn6aMKy0uns2diaMIcUgkWkmVfiEwoeboe90cBPad5ZQGg0DPnD
         uNfwTs72VILMDmlcBJcTcn/QGqI/pfnLIpC6E6rtsLTNl5I78xkpbjULGjdV53YX+/2C
         iQt3pn0bdBBeflRgX9MS0N7aIgzphfIhThvTq62eQMof2KhLC/apKUVMNfA+R2SKXXrC
         7bF08nrBmRrozf4r+JRGtsgzuvq9Am80/Ye3xO0z4Hsrr2l+RphbTXkLvBisB3zjhrn+
         BiZ9CD/4AXz/EpWDc7ZFUUDzIFR2G2YQcQxaNFmGtktJORco0XZamI994/EnhtOuLHxx
         eVFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkU2GDpqbexal4DhTCNlVUBxBSIsgg1VKi2fbgTmBp55TZZz0kFN/+o4QAZaNwy5tkjiGhYnL2b5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMIWiiW2F2tIZYpKT/eKRPApvuRTacA4tCYUvfZCBb/EE4Qh6
	88xN7arn2jcAZO7+q4o4Ysj4d5xTxFKBJ1bfnrRZbF0wY3ox0NOvYzrDrsJGkJ/p7b9osYbxtHO
	JjOWdZP7QV9kM1XB4YJJjmOOt1Ex5EBMZ0qoURfZOFg==
X-Gm-Gg: ASbGncsw41qiUpG35fGS7FJP865c45FHdy1qOjU/Oj1XZLYwUk3SvFrLh5UwByIcbPH
	+06cz4S6FB6cT3DE/Y9A8lN32hHdymf84+XL3AS09QB4kgqTd8M/JON1Oo9gDaJNcb5QZvjTwtk
	iJpuspr1Bz8N4UWfI8t66opsKrq6amPaf8tHurUPkgjOeZsgd66XhoEft5MNCikMtf7uRZ2inqV
	NyBRBZ6eKpqPbV8F0TxD+/bgExx
X-Google-Smtp-Source: AGHT+IGFrVNf0V7c35xNID5UvjWNSDTvtM1F6flQzsxXN+EbCJT+kclZAdeU8ofwKhqzMcWnT5Zz1M5pXcp9/xFZqw8=
X-Received: by 2002:ac8:5a54:0:b0:4ae:cc29:82a2 with SMTP id
 d75a77b69052e-4af10d54f0amr117404121cf.59.1754314239974; Mon, 04 Aug 2025
 06:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lhuh5ynl8z5.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuh5ynl8z5.fsf@oldenburg.str.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Aug 2025 15:30:27 +0200
X-Gm-Features: Ac12FXycZviWqMr6BQfOqXkebdWsgz_PSGKdoF2vPFms50tzfoPTnlZ48Ky1plk
Message-ID: <CAJfpegur9fUQ8MaOqrE-XrGUDK40+PGQeMZ+AzzpX6hNV_BKsw@mail.gmail.com>
Subject: Re: [fuse-devel] copy_file_range return value on FUSE
To: Florian Weimer <fweimer@redhat.com>
Cc: fuse-devel@lists.sourceforge.net, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 11:42, Florian Weimer via fuse-devel
<fuse-devel@lists.sourceforge.net> wrote:
>
> The FUSE protocol uses struct fuse_write_out to convey the return value
> of copy_file_range, which is restricted to uint32_t.  But the
> copy_file_range interface supports a 64-bit copy operation.  Given that
> copy_file_range is expected to clone huge files, large copies are not
> unexpected, so this appears to be a real limitation.

That's a nasty oversight.  Fixing with a new FUSE_COPY_FILE_RANGE_64
op, fallback to the legacy FUSE_COPY_FILE_RANGE.

> There is another wrinkle: we'd need to check if the process runs in
> 32-bit compat mode, and reject size_t arguments larger than INT_MAX in
> this case (with EOVERFLOW presumably).  But perhaps this should be
> handled on the kernel side?  Currently, this doesn't seem to happen, and
> we can get copy_file_range results in the in-band error range.
> Applications have no way to disambiguate this.

That's not fuse specific, right?

Thanks,
Miklos

