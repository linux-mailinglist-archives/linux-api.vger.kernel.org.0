Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8288E1BE77B
	for <lists+linux-api@lfdr.de>; Wed, 29 Apr 2020 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgD2Tgb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Apr 2020 15:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2Tga (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Apr 2020 15:36:30 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E22C035493
        for <linux-api@vger.kernel.org>; Wed, 29 Apr 2020 12:36:29 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h4so3886402ljg.12
        for <linux-api@vger.kernel.org>; Wed, 29 Apr 2020 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+bBufEVKtG0wIvFK4ZP4B4EwU11cS2geVWVY+TG39E=;
        b=JGyW28kKSp2xzCZTcWZWK4kWmeR3vQkEQ6QDmuA8E9wIA9RNbrriB8FyUaougm/qKm
         RR7FZerrH5Mx5BRSvj1O3M9naxbrHejw+W8a0g5BGx++O8hO0jju1bHE88JX3rAQJUfh
         hfGHQ00xD9JxkMGJsJ6jcHCffIB6FCf2FjfpZaDLqsrEKbB4JBYSF3QG9wiCjckRaRCl
         LvQaqvI9EOlW6aQJUITYx3zvK6YDuocbsLbmSspO/S3OIz26MHt+7sqLQUW938bmK1xP
         j2B+5dZdIldS6jhi0v28DX0LHKK13TIHTf9WTGAg+1igpk53eUfzbYkxVsNz6/hKHnyU
         S7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+bBufEVKtG0wIvFK4ZP4B4EwU11cS2geVWVY+TG39E=;
        b=hJtUjGSw/SAE0hbPIlxwxCWKz6u0bHGSyFV/Da3cQ80EPwIPL58CGzKD5pDEk7ut5X
         HBXxUhRkOvyB4AwGIzVX4hxU05AIWqQrBtwtsTSDCIH7rGTD4Eh+PaeUnvjCb0q5Cn/Y
         mYxrcL5JLNX7MmUgcvpQo8tRuFnvEv89UvUylv4EHpKXS+k7z4sXTMMZvH6V4VlH/S5Y
         rZzzqhT7HNH0zKdT9cfy4XRR9JvC1dl1hvjsyJXViqHnws3y5jxYmWpYWbRJAh6GbpI8
         L6LlxzwDp/tJayEdb5bp+WxnRmcRDAdXCL5rqtCz4mwlybVd5epf+/Kdc1ZZekMnjlr3
         XwCA==
X-Gm-Message-State: AGi0PubDhDBGX3YQLhDG8XEMG5AZFBS8j8XFmdV98f4TBLcE7cg0AUOy
        /cYFNJxnoR393uT+mfW8U27aO90cfPz330LyFPEl5g==
X-Google-Smtp-Source: APiQypJdXQoi6q30r4RCMc7z3Y7nOKkXNKLRQaAdGDzZbHTQNG8DusLNtm+dNNLSe3eePAYbVUHRRiXhEjoK6Q0IlVA=
X-Received: by 2002:a2e:87d3:: with SMTP id v19mr20705003ljj.176.1588188987317;
 Wed, 29 Apr 2020 12:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200428192956.GA32615@arya.arvanta.net> <04edfda7-0443-62e1-81af-30aa820cf256@kernel.dk>
 <20200429152646.GA17156@infradead.org> <e640dbcc-b25d-d305-ac97-a4724bd958e2@kernel.dk>
 <6528f839-274d-9d46-dea6-b20a90ac8cf8@kernel.dk>
In-Reply-To: <6528f839-274d-9d46-dea6-b20a90ac8cf8@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 Apr 2020 21:36:00 +0200
Message-ID: <CAG48ez2k_CvXxVHW9WB+GV_+41PoKmVk0m_b_1sZaOAbnJUC1A@mail.gmail.com>
Subject: Re: Build 0.6 version fail on musl libc
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>,
        io-uring <io-uring@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

+linux-api

On Wed, Apr 29, 2020 at 6:14 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/29/20 9:29 AM, Jens Axboe wrote:
> > On 4/29/20 9:26 AM, Christoph Hellwig wrote:
> >> On Wed, Apr 29, 2020 at 09:24:40AM -0600, Jens Axboe wrote:
> >>>
> >>> Not sure what the best fix is there, for 32-bit, your change will truncate
> >>> the offset to 32-bit as off_t is only 4 bytes there. At least that's the
> >>> case for me, maybe musl is different if it just has a nasty define for
> >>> them.
> >>>
> >>> Maybe best to just make them uint64_t or something like that.
> >>
> >> The proper LFS type would be off64_t.
> >
> > Is it available anywhere? Because I don't have it.
>
> There seems to be better luck with __off64_t, but I don't even know
> how widespread that is... Going to give it a go, we'll see.

If you have questions about how to properly write UAPI headers,
linux-api@ is probably a good place to ask.
