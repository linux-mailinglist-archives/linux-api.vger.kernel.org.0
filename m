Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99BF12D365
	for <lists+linux-api@lfdr.de>; Mon, 30 Dec 2019 19:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfL3S3r (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Dec 2019 13:29:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45924 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfL3S3r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Dec 2019 13:29:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so47235413otp.12
        for <linux-api@vger.kernel.org>; Mon, 30 Dec 2019 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d9RUOUhHNYZ8b+xHO9R34q8NE4khkHtdBl8RVjB8OyE=;
        b=HYJPn2l+9Nf1Ii8FNdoU7z+ztmZohzKhAhCgRr3RN+6zN4u9yI7ORNKhiE9nqLDIvu
         IWUkPJ7hGmVUAiLEtRECq5FEm1puNA9nFehQeLwWvTl7RYAatnW0Q2zCYCK+pTU747A8
         p10sb5KUHvyBJXiRuAZ9hkkNC6Ql477LxPfws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d9RUOUhHNYZ8b+xHO9R34q8NE4khkHtdBl8RVjB8OyE=;
        b=TslCxBbvAj9OVHcIVVh6jlAtDKzYnZcGPC/kYpIRAe54U9YhJFignKKvobZ2ZAcvbe
         dtZfOZwh/Ww8LZyVASX/Sgf75CWHG+AyRhV3Fn24ULlyi50EvKCLQOv/vW+BOIuJm7Yt
         7gG2jE8XqNqvyf5jmxO/xd4OEmHQ2fmPw6CkMt/cjaPzp1ye/9Si3PecOVNTqyny8pAt
         Q7+15IDECRI4qZt9PuBPMmPrN3y95KwkQAuoV7HL9m7LHq+niuhxQkxnkKdwt/+H4sTt
         F28zBhm5A5qJmi7QBv1GMApsffuZfyAL8nUjX3heaV+uKx0omAod8nNyE3kfzrMq+0vg
         nrWQ==
X-Gm-Message-State: APjAAAU64/YuRpdk8iJvi5ZAFS8u0e+gKcXi3KrxhrQOzUjtyMGclihk
        nWC4hxr6h+lAAka0fAd8xrAX8Q==
X-Google-Smtp-Source: APXvYqwDdsIS4g3FqEpGh+fozJ77By/dRChmx1Ui4Q8M7CdzFtu+0DPgHwxq0gwmCS5vUufaPGzMhQ==
X-Received: by 2002:a9d:4b05:: with SMTP id q5mr61198349otf.174.1577730586464;
        Mon, 30 Dec 2019 10:29:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w72sm14023710oie.49.2019.12.30.10.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:29:45 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:29:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v3 1/3] samples, selftests/seccomp: Zero out seccomp_notif
Message-ID: <201912301029.46A91074BC@keescook>
References: <20191229062451.9467-1-sargun@sargun.me>
 <20191229161126.xcrnzdqu5frrov6q@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229161126.xcrnzdqu5frrov6q@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Dec 29, 2019 at 05:11:28PM +0100, Christian Brauner wrote:
> On Sat, Dec 28, 2019 at 10:24:49PM -0800, Sargun Dhillon wrote:
> > The seccomp_notif structure should be zeroed out prior to calling the
> > SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
> > whether these structures were zeroed out or not, so these worked.
> > 
> > This patch zeroes out the seccomp_notif data structure prior to calling
> > the ioctl.
> > 
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Reviewed-by: Tycho Andersen <tycho@tycho.ws>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Thanks!
> Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks for this series and the discussion! :) I've applied this to my
tree for Linus.

-- 
Kees Cook
