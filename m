Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE7C12BFC9
	for <lists+linux-api@lfdr.de>; Sun, 29 Dec 2019 01:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfL2ASV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Dec 2019 19:18:21 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34494 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfL2ASV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Dec 2019 19:18:21 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so28693772iof.1
        for <linux-api@vger.kernel.org>; Sat, 28 Dec 2019 16:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0TVhVG6FPueBWbxT9lQzkvtYNLfiEe1VkHsG9qF7cLw=;
        b=EVP7Sf6HkWOiXoLb9OQHzPQdTVjwelJGvS4vCCJrE6c+OKje8z7CBxxD+eSrcXwzrI
         wS5DHPQgA3ZZk0XwcXGCoMxjsqB49hXO0uta1BdP9GX+EidrZQg2OKzaPXKpU03ti/vW
         WoQv1haLJ9ffvLberQtQvvrNavWYYIYYDQD/O8r+U8o26AR2DqCq2OHXl51Cpf4lvol0
         hXqT/J/7EgxrH4QuY6nFvo4lOGS1joXg1leP5EnjlBVuVZWSXRp8UzKXOUbAV44JmRvG
         MmexE7kz5KFj3zs30EoTqe9VKdGTn0nGJEScB0gwWnzwxhzmQkzn8w0JFYWPRIQ7iC1E
         dCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0TVhVG6FPueBWbxT9lQzkvtYNLfiEe1VkHsG9qF7cLw=;
        b=D85yQXom95Pd/nioj3jGl4YAIPSD4pV1LX2rJw1sVxq1vSBCssf9MnHDXpv/qtabjM
         2UX2gIdHYkXAiQ8lSPBjdjKcJ73EsfwR45oeg7RvfY+RCdD9hPY35MZ9+09e1uCcgJMf
         QGj1KGN9X78aygQIuoIPEjooC+DQXFW8gMfwF4eKaw0yjbQgVMbKZ8/cGgwParY6LrWG
         iXsEdR5QPhooJmppfG5vXlIalHCzNvREDdbN9mg9a9IeHTCY/uEWpC+g347rui5T+jZn
         efEqhao89D56wJ8RyebTQqGJSpyda+f66+qEF1krygIB1clZROkCDZjBuBQ/RlywYUrS
         JKSg==
X-Gm-Message-State: APjAAAVfeWX6YVqEMaVCFa0brUE9IsnRTFFUG0LzODrJUzmTMqw/yTN7
        spi61Eq2CsoN0HGjbaqIzWvrKA==
X-Google-Smtp-Source: APXvYqz3D2CFRJnZ1pTL1abfRRJwvnlpNObu1eijnBoZ2hLXjkFCpXcnDaAlLxOPdtp5Jzuyo22EjQ==
X-Received: by 2002:a05:6638:a31:: with SMTP id 17mr45396672jao.15.1577578700376;
        Sat, 28 Dec 2019 16:18:20 -0800 (PST)
Received: from cisco ([2601:282:902:b340:f166:b50c:bba2:408])
        by smtp.gmail.com with ESMTPSA id c8sm14934153ilh.58.2019.12.28.16.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 16:18:19 -0800 (PST)
Date:   Sat, 28 Dec 2019 17:18:18 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2 1/2] samples, selftests/seccomp: Zero out seccomp_notif
Message-ID: <20191229001818.GC6746@cisco>
References: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal>
 <20191228181825.GB6746@cisco>
 <CAMp4zn91GoB=1eTbc_ux4eNs2-QFm+JocodgFQYUiiXL7H4m9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn91GoB=1eTbc_ux4eNs2-QFm+JocodgFQYUiiXL7H4m9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Dec 28, 2019 at 07:10:29PM -0500, Sargun Dhillon wrote:
> On Sat, Dec 28, 2019 at 1:18 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Sat, Dec 28, 2019 at 01:48:39AM +0000, Sargun Dhillon wrote:
> > > The seccomp_notif structure should be zeroed out prior to calling the
> > > SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
> > > whether these structures were zeroed out or not, so these worked.
> > >
> > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > ---
> > >  samples/seccomp/user-trap.c                   | 2 +-
> > >  tools/testing/selftests/seccomp/seccomp_bpf.c | 2 ++
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
> > > index 6d0125ca8af7..0ca8fb37cd79 100644
> > > --- a/samples/seccomp/user-trap.c
> > > +++ b/samples/seccomp/user-trap.c
> > > @@ -298,7 +298,6 @@ int main(void)
> > >               req = malloc(sizes.seccomp_notif);
> > >               if (!req)
> > >                       goto out_close;
> > > -             memset(req, 0, sizeof(*req));
> > >
> > >               resp = malloc(sizes.seccomp_notif_resp);
> > >               if (!resp)
> > > @@ -306,6 +305,7 @@ int main(void)
> > >               memset(resp, 0, sizeof(*resp));
> >
> > I know it's unrelated, but it's probably worth sending a patch to fix
> > this to be sizes.seccomp_notif_resp instead of sizeof(*resp), since if
> > the kernel is older this will over-zero things. I can do that, or you
> > can add the patch to this series, just let me know which.
> 
> I was thinking about this, and initially, I chose to make the smaller
> change. I think it might make more sense to combine the patch,
> given that the memset behaviour is "incorrect" if we do it based on
> sizeof(*req), or sizeof(*resp).
> 
> I'll go ahead and respin this patch with the change to call memset
> based on sizes.

I think it would be good to keep it as a separate patch, since it's an
unrelated bug fix. That way if we have to revert these because of some
breakage, we won't lose the fix.

Cheers,

Tycho
