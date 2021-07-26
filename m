Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D966F3D69F4
	for <lists+linux-api@lfdr.de>; Tue, 27 Jul 2021 01:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhGZW1R (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Jul 2021 18:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhGZW1R (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Jul 2021 18:27:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDE3C061760
        for <linux-api@vger.kernel.org>; Mon, 26 Jul 2021 16:07:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so2220729pji.5
        for <linux-api@vger.kernel.org>; Mon, 26 Jul 2021 16:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sxoJWn9TB1KKIK9RMcPMr463nTvNmAuT8l6d2lNAt6w=;
        b=IttE0CeQ8dXkx8DCEsI5NCkLW794y07admt8aWMeu3joKj2oPeh+Mb361NQJKPVI+T
         MzB0w9wIQCfMl3YbYYPaaloKujShMMoIx3O7f0Vj7Ge7udHEW5kbXEYSngui0sC46J77
         XgdKrX5DjrDCVoktWZ/20cS2zQWRXgvRlXglTQW986jmQhZTs9baSNNJSkvgl4eAKt0b
         EYl9RMAJCffLJwcK8tDOCpk5hF0A0c+IlNiXXEBKoCL4Mv8tB63G1Cf6aPjNOl0wyFVD
         bGjz9wHhaPF6mUeD6kACLzQ5PvrS1j0vFNoIdkTPn6Ky7+66s3/RQph/t2eCYOhPsojz
         8WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sxoJWn9TB1KKIK9RMcPMr463nTvNmAuT8l6d2lNAt6w=;
        b=YxWplPsqAhqDVvwkZEiAPgJ+qdAQiRRcTcgXFvXlTkIYdmlwbp87rgIGNb+8zYCtTz
         9+jbUsBdD3iPQVl9CpKvjGzuQ/WRShFRm8mo94hvTPqUqTz8X/GmvzjWTjFRkXeavp4Y
         niEs4Vtzi9rAi04QI66/yX+cECgnS8xcEBeUrhMJluGye2gmtd33UGbr1ldmfCtovA8z
         eGL0yp6ZLVwyE8yfq/UNvxPRfVD3aQ+rzRj3hIlIq7AxvMotKMtKxY/hDiLDiKFY+q6o
         0XCVTLVeAkrrPC4LVkZvIFPEKz6aU3i0n149cCBuKokNJ7gm8bZrwfcx4lcTfQO/dQ69
         tRoQ==
X-Gm-Message-State: AOAM5311S3EjOzqJsLeHk10nemD4f11nvqKc1101CouzDze8Q8hUcstd
        1Ta9X5uL+DV5SZNRaHSxVqp6XQ==
X-Google-Smtp-Source: ABdhPJy4GG9zZhu4cOzFgHHwxIdgpJiKeMNzec6n4+BGf5yNRSI/Pv3FIOvCg7RfbWRJqFu4WMIAEA==
X-Received: by 2002:aa7:9517:0:b029:35e:63f3:64a2 with SMTP id b23-20020aa795170000b029035e63f364a2mr20380909pfp.74.1627340861198;
        Mon, 26 Jul 2021 16:07:41 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c253:e6ea:83ee:c870])
        by smtp.gmail.com with ESMTPSA id x26sm1106821pfj.71.2021.07.26.16.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:07:40 -0700 (PDT)
Date:   Tue, 27 Jul 2021 09:07:28 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Add pidfd support to the fanotify API
Message-ID: <YP9AMGlGCuItQgJb@google.com>
References: <cover.1626845287.git.repnop@google.com>
 <CAOQ4uxhBYhQoZcbuzT+KsTuyndE7kEv4R8ZhRL-kQScyfADY2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhBYhQoZcbuzT+KsTuyndE7kEv4R8ZhRL-kQScyfADY2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 21, 2021 at 10:06:56AM +0300, Amir Goldstein wrote:
> On Wed, Jul 21, 2021 at 9:17 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > Hey Jan/Amir/Christian,
> >
> > This is an updated version of the FAN_REPORT_PIDFD series which contains
> > the addressed nits from the previous review [0]. As per request, you can
> > also find the draft LTP tests here [1] and man-pages update for this new
> > API change here [2].
> >
> > [0] https://lore.kernel.org/linux-fsdevel/cover.1623282854.git.repnop@google.com/
> > [1] https://github.com/matthewbobrowski/ltp/commits/fanotify_pidfd_v2
> > [2] https://github.com/matthewbobrowski/man-pages/commits/fanotify_pidfd_v1
> 
> FWIW, those test and man page drafts look good to me :)

Fantastic, thanks for the review!

I will adjust the minor comments/documentation on patch 5/5 and send
through an updated series.
/M
