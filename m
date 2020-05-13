Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE1C1D0985
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2020 09:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbgEMHH6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 May 2020 03:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgEMHH5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 May 2020 03:07:57 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD69C061A0C
        for <linux-api@vger.kernel.org>; Wed, 13 May 2020 00:07:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v5so8599055lfp.13
        for <linux-api@vger.kernel.org>; Wed, 13 May 2020 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mW8RDOfapkDaoa0Hb9EShwMwCn8vakzjoyWs3SU+BGc=;
        b=J9qIkN4GOdr3b0TDdPyfF5iwQMxySZVVwyEt4C2nQgvCPYow2lWfeAh6Hp3j2u3g+0
         CpAXZ6pgAlgu0Ac73YY7tSAw8K/WpZwe+TL3PY2N7q4H3UgoHoR4E6LAZb8BH8Uz5BA9
         CxtS+rvDyaC4WK604GPAD+E7pJgAu0if/r4q3rMZ3gPPEPNWMJSBVkCxXcTwQEl/+Yp9
         nFBEKSpOH3hes9GiSy/N6Wuq+8s6+uIG3u9MDIxDbNkwklUr38268FXRPsFgWahImOOK
         8sbQIU05WISkLCPgzq+D6VBy9LU2GtYEyPW9tSD+GlaCyHxbY5VsYmBhcZuLsS+9bE7Z
         tHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mW8RDOfapkDaoa0Hb9EShwMwCn8vakzjoyWs3SU+BGc=;
        b=sspo8RYXxTSmgiopJ2IlkEZhMCABuRXDD3k9CLAyMIye4knXab1xgUcVId9pe9RWeY
         hsy5P7dCCNvF3HCV/lKRKr41yEEcnrRgWMIJosS8U4rQeodcG9odABtG7P2zNQP9qc8L
         WRaVXFOGhsq2Cpu4zvgJUS/84JbkX3n81aOhJpDdw2vwDA++TkTtgZVMKzHO6neF6fmX
         Q96Y+fvGGvcbC8UMydoPfUNinu08zElNKJVF/X/c8Nw4F/fWH6h5MvwF3cA+z3NF4SKY
         bVH3QbHrZwy640C4ii27pM+VgOy3VUMT7/Xj73yCq0BiVbulrW7pr9effGO1mQouyjkh
         8L4g==
X-Gm-Message-State: AOAM533lh/x6YTvKskZIcfzkbWgup0szxPIh7BWQnufq0KYQssOtLZvp
        RpwzVTXTRlE4q+fMKL/oWmgnndG3mft3tiVdMB1wvA==
X-Google-Smtp-Source: ABdhPJzDwBLW0Ng55ay6pVZ/lv4nKFNfw9bBAXMfoDctZFD/KSd0XtGRMmmuj+JMpqtM15bEUnfuAGGNF+u0G5wmXU4=
X-Received: by 2002:a19:ec7:: with SMTP id 190mr17595542lfo.203.1589353674058;
 Wed, 13 May 2020 00:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com>
 <CAB0TPYHwor85-fWKu+OMT-1ys2L7OSqVoReJRzNOMAE0xK+yzg@mail.gmail.com>
 <1f3064a9-105f-02bb-6a1a-eb9875d292e3@kernel.dk> <4416f60a-6050-5067-6881-0ee9ef944669@kernel.dk>
In-Reply-To: <4416f60a-6050-5067-6881-0ee9ef944669@kernel.dk>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 13 May 2020 09:07:43 +0200
Message-ID: <CAB0TPYHikHc3tTTQcUOOZsYZmqNxGtthpkPX_z6dKgy+V8kovg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 13, 2020 at 4:30 AM Jens Axboe <axboe@kernel.dk> wrote:
> > Looks acceptable to me, but I'm getting a failure applying it to
> > for-5.8/drivers on this patch:
> >
> > Applying: loop: Refactor loop_set_status() size calculation
> >
> > So you'll probably want to respin on the right branch.

This series depends on a separate bugfix I sent to LKML earlier - see
https://lkml.org/lkml/2020/3/31/755 . I mentioned it in [00/10] of
this series, but perhaps I should have just included that patch.

I just verified that patch + this series still applies cleanly on your
for-5.8/drivers tree, but if you prefer I send a v5 with that patch
going first let me know.

Thanks,
Martijn



>
> Then you can also drop patch #1.
>
> --
> Jens Axboe
>
