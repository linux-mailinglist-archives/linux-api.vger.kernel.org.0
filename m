Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5918E1C6DC8
	for <lists+linux-api@lfdr.de>; Wed,  6 May 2020 11:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgEFJ5f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 May 2020 05:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728663AbgEFJ5e (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 May 2020 05:57:34 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B4DC061A41
        for <linux-api@vger.kernel.org>; Wed,  6 May 2020 02:57:32 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u4so808093lfm.7
        for <linux-api@vger.kernel.org>; Wed, 06 May 2020 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IciAwSgUVdB2/0PlCfDzeZhlzx2IzeWzIis4PFV64U=;
        b=rjnasmRUS1qEdjQp+ja6ha+agOWNjFUJ0msq1PCXadJGzv7jxsQw6WX+NoEgi2nRWQ
         KCdRe7egxySgra2xJjU2E/AXfi0H7SNJVzEGctfHwMYVzWtkPFNj62uxoq3xhoRsr1Nb
         r3OhCQW9bCzOSwwCvogQnjH0NHyzKOXeCsqr4Qha1IkNlOFtq9X1SnfpNQqWE+MWQdKv
         G3UyZzqao+FN4/VlQPr4Jy/EyIAFIKuihtkJ0swRQTBVAVUNmgGrTF1xtH4wmBwyCus/
         S/+wx9Wl1EaSF62yyCN0rVRaw4bmGSaj//EWLvwNBXkV5M7+adjdhIC/5VMpESg6YA1Q
         27BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IciAwSgUVdB2/0PlCfDzeZhlzx2IzeWzIis4PFV64U=;
        b=YrfdCyf2EDuXCfWsl6yBaiJ4H57ekdAbHUwtDpRZWqvudjdHbOrTGXz1YEQDXdI5yQ
         4WZV76BgjgwVgLm0mSIYMMiIICgksWy7F5zPN8jyXhOBwF3PnpNQGPjeK3sYQtmbokHM
         ubnrNIeWOzifhbcSnIU8sWXY2A4Z6gGFWi29T2G4WkzePuvIb2gtcYZCBg2PqGYXjvlh
         mMhpB6Qal9XOrq3SgEsasOQIxbqtJehfAqg6QEPsjvOYxgy7Ezw7R4Kjz+m8Xx6E/ADt
         9Bjum2w2rS+eIZA3i3dy/2dzqa/ZSHoHN/xnDCOPc/7P/liHMo35Zak9A/8MqSh3nyoP
         WZrA==
X-Gm-Message-State: AGi0PuaU655clrtCqQrYS6w3cNG3a3sOPrEFxIie9/dYSdLu0T5OXpgS
        ms8jNQI3r6PaLpANBZiHWenb4jYLs8hGrAoPVEEmiA==
X-Google-Smtp-Source: APiQypKjKckRZENGEavMmGfKLuKsPiGZebpMxZI0LFDcf1uG4zlU1bqJhKI4tYpjLuic788pKPSvUVEiOIwiVaqSoXY=
X-Received: by 2002:ac2:5988:: with SMTP id w8mr4606822lfn.75.1588759051401;
 Wed, 06 May 2020 02:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com>
 <7d73bafe-5228-b02e-5b53-4a41543aebe3@gmail.com>
In-Reply-To: <7d73bafe-5228-b02e-5b53-4a41543aebe3@gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 6 May 2020 11:57:20 +0200
Message-ID: <CAB0TPYGKmbeNt94CSMhXd0EuFpSM14DEYAwoGdhY79s=H9o1+g@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 6, 2020 at 11:44 AM Michael Kerrisk (man-pages) >
> Can we have also a patch for the loop.4 manual page please?

Ack, will do when the series lands.

Best,
Martijn

>
> Thanks,
>
> Michael
>
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
