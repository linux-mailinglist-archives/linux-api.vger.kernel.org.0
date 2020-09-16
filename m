Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC6326BBF4
	for <lists+linux-api@lfdr.de>; Wed, 16 Sep 2020 07:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIPFrZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Sep 2020 01:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPFrY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Sep 2020 01:47:24 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA75C06174A;
        Tue, 15 Sep 2020 22:47:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so8594490ejb.1;
        Tue, 15 Sep 2020 22:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQiJOB/UdJOF4poHaKg0u3Y1sMH91TcjjSLPEnuargo=;
        b=bZwjDS/6nCw1FqZcriRPBeuMMfwH8PHl9L5lA7qiqEDP3rDAcAcNgGPDO0zOaynrGm
         5Cpt+rzvXSpDcaBoN1ds22Y0ceJv4fgRJtmrugLhO6lcVQc82BPA479Vzz/xl9h1WEFS
         QIkg672Skh97B/sQbTRVncS3wFgY8pXP+j9FipZx+ELD08i+oqQMfR93WM1b5WMLZc2J
         19fERFIV4gHmhmV7zyxjRgnIESCRDLJuAZxUGycAX8dJidbgfjYwBGUWK+Aj2RcMfolD
         0+yIFsmbDhGxmiq8bR7cHoj8DBMqpNi9Oc3Tt+w0JsHm3E7gF/4katlrJc3MNoWRkjy3
         Qz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQiJOB/UdJOF4poHaKg0u3Y1sMH91TcjjSLPEnuargo=;
        b=NzfttC/JIgQ4/+Ymua2YoXJnLYNh0MKFlbahh76jboAMCUfNXXMpcR2F7iYkfiOfEO
         XnH5z+0l0q6t4VRPhO8GvNxAZzI0pkk9up0SGB6zMrkQHgP7wXMEdUOXDyVOWBbPUJaG
         6vsqKu4BLtpdCbSNSta5Aubq/ZUHonK1UylOlDhmXc/DgAKdo0OWH4bRm+sAnJK00qHn
         UqgV7snybC7R5jJsjaSVUccwujmB3kaNn65TFZ+J+dN7rwzQxpkf2lCvKH8t2fP8rQ50
         jWvEFiIw154rJrEiNjBor3X/skFMlBk8XKUOC2IWAMe3ifD7iTKN3Cs+Uq0HSWH+TqNA
         roJQ==
X-Gm-Message-State: AOAM5335h6iq/p6KsZYJOADqwmwk16cJNKlKeafgRwo1VOjcc4F13Dnt
        /+nviumx2M8QpV0QCuhxNMk+od4lPyXWU6UaXrh+3UP4o5o=
X-Google-Smtp-Source: ABdhPJwGsZk/mogHqr3oAyP56+OJiYK3EKSenA9xR3UUMnUzp8mWjJMt6fotj/nkmcbn8dZeWcuqYDUaLfO+eApUwTg=
X-Received: by 2002:a17:906:5488:: with SMTP id r8mr23235909ejo.483.1600235242767;
 Tue, 15 Sep 2020 22:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com>
 <20200906012716.1553-1-tom.ty89@gmail.com> <20200906012716.1553-2-tom.ty89@gmail.com>
 <20200907060927.GA18909@lst.de> <CAGnHSEnWPSaM3xS1MtFUJDrSZPfaH_VwAiQ5UkndFTVe3uWNVA@mail.gmail.com>
 <20200908084258.GA17030@lst.de> <CAGnHSE=ASs3DG2yp1NpODHimwxHe+=XPRsOyDdkB3ThtyEU-KA@mail.gmail.com>
 <20200910052835.GB18283@lst.de> <CAGnHSE=pcW0zJMSaowdsRXFa=TmOeidekgvDuEPB8PU7mheXNA@mail.gmail.com>
 <20200911064844.GA22190@lst.de>
In-Reply-To: <20200911064844.GA22190@lst.de>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Wed, 16 Sep 2020 13:47:11 +0800
Message-ID: <CAGnHSEmHDABNOEKyvp2zjPbYjDasdzo-QjxNC8xwh4MnnuDJgQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/4] scsi: sg: implement BLKSSZGET
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>, akinobu.mita@gmail.com,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 11 Sep 2020 at 14:48, Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Sep 11, 2020 at 10:52:19AM +0800, Tom Yan wrote:
> > > How is that an advantage?  Applications that works with block devices
> > > don't really work with a magic passthrough character device.
> >
> > You must assume that there are applications already assuming that
> > work. (And it will, at least in some cases, if this series get
> > merged.)
>
> Why "must" I assume that?

Because of the name. The whole discussion was about the name. (Well,
also because 'I must assume that some applications has already been
"relying" on the wrong name.')

>
> > And you have not been giving me a solid point anyway, as I said, it's
> > just queue_*() at the end of the day; regardless of whether those
> > would work in all sg cases, we have been using them in the sg driver
> > anyway.
> >
> > And it's not like we have to guarantee that (the) ioctls can work in
> > every case anyway, right? (Especially when they aren't named SG_*).
>
> No.  While it is unfortunte we have all kinds of cases of ioctls working
> differnetly on different devices.
>
> >
> > I mean, what's even your point? How do you propose we fix this?
>
> I propose to not "fix" anything, because nothing is broken except for
> maybe a lack of documentation.

It won't really help anyway. Documenting something wrong won't make it
correct anyway. It's just wrong, semantically wrong, logically wrong;
expecting people to "rtfm and realize the difference" only makes it
even more wrong. End of story.

This was never about whether it is "broken" or whether we should
provide means to fetch the limit in the number of bytes or sectors. It
was always just about the name.

Just one last question. So should we not even replace the bit shift
with queue_logicial_block_size() in max_sectors_bytes()? Given that we
"must assume that it has been that way for long enough so applications
must have been dealing with the flaw on their own already and fixing
it will only breaks them"?
