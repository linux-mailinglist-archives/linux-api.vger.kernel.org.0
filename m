Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975974CCA6
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2019 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfFTLKk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 07:10:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43046 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfFTLKk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 07:10:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so2567018wru.10
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 04:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JhYlbuI4DFmnCfRHlNZboigE7pfx/C6qRT9qZ4a8a8c=;
        b=MeJ3KK8EMD0ilu4JR97aFwXUI5LCoCXeciWdc/TkykOLZhPWpxnpBgfxp7NDYtLRN9
         7FSUf7L/97ZxnuM2+a1LsEc5YXV0icjFv9C5oPmvRjJAwCjinmdkarmKmjTYCRlG+/bz
         1LFOS48271sqCIhqg7/ekqIWwlrZDchBCh7MiAFmrE1e1AggV2idSH708AkzpNb4RdaC
         M2XgZ245Nn20ZPUtfW7xpsOO6Xuo8UeBbVhDLAIVcIqeHv30hnnjJsU+r2pbozdQJ6BH
         kVsov2ZCAWafyP+2hpHv8Pyc6wONjyJosTqgHlCDTnmwlrFviJjem8qNac0xNK4tbpxH
         /G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JhYlbuI4DFmnCfRHlNZboigE7pfx/C6qRT9qZ4a8a8c=;
        b=Xz5uLUobm/QSNhlLIzqaTlDfTWhZ69I/o3IAYWVrKccnlHsQnxF61XFlIkPhvBZP9w
         ywOX17oPvnWdW28G8NPuXW+9wGCAWYyILR1HtzPHTQDRDYNH7WsM5Nj+6FT39gEPV+Zx
         zesjUnEg5hkot3xRS1Ql/IbrUIe9TxDSwqjrSjsQ/Kjz4KZiTfEJsC/jYyT4yi65r2be
         sHm5LT9PchK81hd05uzz5vBPMRVJy2phmQU15YYb4lzG/cD4CeGaISd91GiU4mOwmi1T
         ww16a2v6uvu8vEX7od/m+alESIn4XtHWDVe6nXzsKeOVlbz9+YFgLhr4v8qNbn4Sgxsd
         S2cA==
X-Gm-Message-State: APjAAAU7rV8jrJpFeIx6N+cggEg5eivAWkuHHe7iBSdt2yBQrRsqD11r
        402JiNawNqCktqJbENTNkfyxgw==
X-Google-Smtp-Source: APXvYqwb//NAW++WCfhs0Zqqp92HPqqFllfWn6agS2IoFgTab1kkxgF/r75jUCi/2cYBwdsQkTZCgA==
X-Received: by 2002:a5d:4703:: with SMTP id y3mr33135290wrq.35.1561029038472;
        Thu, 20 Jun 2019 04:10:38 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id c4sm28178583wrb.68.2019.06.20.04.10.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 04:10:37 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:10:37 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: make pidfd-metadata fail gracefully on older
 kernels
Message-ID: <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620110037.GA4998@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 02:00:37PM +0300, Dmitry V. Levin wrote:
> Cc'ed more people as the issue is not just with the example but
> with the interface itself.
> 
> On Thu, Jun 20, 2019 at 12:31:06PM +0200, Christian Brauner wrote:
> > On Thu, Jun 20, 2019 at 06:11:44AM +0300, Dmitry V. Levin wrote:
> > > Initialize pidfd to an invalid descriptor, to fail gracefully on
> > > those kernels that do not implement CLONE_PIDFD and leave pidfd
> > > unchanged.
> > > 
> > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > ---
> > >  samples/pidfd/pidfd-metadata.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/samples/pidfd/pidfd-metadata.c b/samples/pidfd/pidfd-metadata.c
> > > index 14b454448429..ff109fdac3a5 100644
> > > --- a/samples/pidfd/pidfd-metadata.c
> > > +++ b/samples/pidfd/pidfd-metadata.c
> > > @@ -83,7 +83,7 @@ static int pidfd_metadata_fd(pid_t pid, int pidfd)
> > >  
> > >  int main(int argc, char *argv[])
> > >  {
> > > -	int pidfd = 0, ret = EXIT_FAILURE;
> > > +	int pidfd = -1, ret = EXIT_FAILURE;
> > 
> > Hm, that currently won't work since we added a check in fork.c for
> > pidfd == 0. If it isn't you'll get EINVAL.
> 
> Sorry, I must've missed that check.  But this makes things even worse.
> 
> > This was done to ensure that
> > we can potentially extend CLONE_PIDFD by passing in flags through the
> > return argument.
> > However, I find this increasingly unlikely. Especially since the
> > interface would be horrendous and an absolute last resort.
> > If clone3() gets merged for 5.3 (currently in linux-next) we also have
> > no real need anymore to extend legacy clone() this way. So either wait
> > until (if) we merge clone3() where the check I mentioned is gone anyway,
> > or remove the pidfd == 0 check from fork.c in a preliminary patch.
> > Thoughts?
> 
> Userspace needs a reliable way to tell whether CLONE_PIDFD is supported
> by the kernel or not.

Right, that's the general problem with legacy clone(): it ignores
unknown flags... clone3() will EINVAL you if you pass any flag it
doesn't know about.

For legacy clone you can pass

(CLONE_PIDFD | CLONE_DETACHED)

on all relevant kernels >= 2.6.2. CLONE_DETACHED will be silently
ignored by the kernel if specified in flags. But if you specify both
CLONE_PIDFD and CLONE_DETACHED on a kernel that does support CLONE_PIDFD
you'll get EINVALed. (We did this because we wanted to have the ability
to make CLONE_DETACHED reuseable with CLONE_PIDFD.)
Does that help?

> 
> If CLONE_PIDFD is not supported, then pidfd remains unchanged.
> 
> If CLONE_PIDFD is supported and fd 0 is closed, then mandatory pidfd == 0
> also remains unchanged, which effectively means that userspace must ensure
> that fd 0 is not closed when invoking CLONE_PIDFD.  This is ugly.
> 
> If we can assume that clone(CLONE_PIDFD) is not going to be extended,
> then I'm for removing the pidfd == 0 check along with recommending
> userspace to initialize pidfd with -1.

Right, I'm ok with that too.

Thanks!
Christian
