Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559131C6DBD
	for <lists+linux-api@lfdr.de>; Wed,  6 May 2020 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgEFJzr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 May 2020 05:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728306AbgEFJzr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 May 2020 05:55:47 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350ECC061A0F
        for <linux-api@vger.kernel.org>; Wed,  6 May 2020 02:55:47 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h26so805518lfg.6
        for <linux-api@vger.kernel.org>; Wed, 06 May 2020 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1a2PkwV2T8+2DItaMD9IItjhWohAns0GTTh7+ScaUs=;
        b=LEfzudg1N43QZjTlPIxvvlD34Fb6yTWkxh+eLzWYTWcd/9UIKEfv5stX7ryBfvg9g6
         4FEWoUoC0LtPshkhjHT4vcyfMfYAn7ZPnLGdV5/iXBcWvyh64jodk2owgmeghnA//F6e
         ZtjpQwu9epWZIkLsWcpWCdbHh5nw0dZvRcxTyoYXHqY1aiPCLmegMHCyERwAWp8D5r4x
         q/dUEV4ApkG8PhkWIGCcm4QybyLXmsMtZCsXevtDVeVEdX96M2IQT15/txUTjfBPfHLH
         JlWG+5IWq6iYWsB5a2TRaUPEHo4iV6r8MtxUDWgVqL4/4pHEP//ovBgnH47kQDKJep1D
         OMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1a2PkwV2T8+2DItaMD9IItjhWohAns0GTTh7+ScaUs=;
        b=lp4Gs66pp7D1zwptxHQ7zbn4zXpduT0a6IS6RXWmKbVBsVzybZOyJZDP02aY6ozb01
         hoPUC6BuL/skOoSX2mJv7ncZJJQSwXLbyuFec9oEKmJpsV903GMZFHzrE0PbBGYHWAVt
         DwKQrXeP+ZyB266uz6YMnKT/JUXvnLl7yT2b/pWiyNWi6pLEG2Y6VdC4vqGSTQJqDxP7
         PWzyWcUKi+czW1T0D+Vg/alJoqdZhVqbp2Mh4ETdXynNi2nMQG/h3KN5VaXpd2M8wlCM
         VhBPnf4u1MmeC0Ai8Sdp4G4HncILHdJ080Ge2kEzncEy8UQWRjGchF1Wp3nq89JaI7sj
         UVCQ==
X-Gm-Message-State: AGi0PublByk2QKYvcLN7ON5J5g2FmsaKWi0J3L0DMq1K41QtbPlDMtyd
        cd4G+WkVQZy9utI87nWvSil8RGpTANfz2iPME34GNg==
X-Google-Smtp-Source: APiQypLdNRgTNoQn8s2a3BYqZvwycVrjdkmthqtUlOrX/8qrQhGr8sPiDSuHTs/DQ6SNcIRcaTksALi7ftLxDj5RWzI=
X-Received: by 2002:ac2:4546:: with SMTP id j6mr4684635lfm.203.1588758945507;
 Wed, 06 May 2020 02:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com>
 <20200506060944.GG10771@lst.de>
In-Reply-To: <20200506060944.GG10771@lst.de>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 6 May 2020 11:55:34 +0200
Message-ID: <CAB0TPYEz=GLWEtBX5ndd1p-wBRBwVAOqBW=E1rTvRrLYRgiFqQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
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

On Wed, May 6, 2020 at 8:09 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Thanks, this looks very nice!

Thanks! And thanks for all the feedback, it has made this series a lot cleaner.

>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Are you also going to submit a patch to util-linux to use the new
> ioctl?

Yeah, I'm happy to - will do it as soon as the series lands.

Best,
Martijn
