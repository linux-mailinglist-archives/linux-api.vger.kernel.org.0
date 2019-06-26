Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00862571E4
	for <lists+linux-api@lfdr.de>; Wed, 26 Jun 2019 21:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFZTjn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Jun 2019 15:39:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34695 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZTjn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 26 Jun 2019 15:39:43 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so4513740iot.1
        for <linux-api@vger.kernel.org>; Wed, 26 Jun 2019 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrgKV2laxb7CmMhAO2Zht6dY5cjmqevbQFQ/CfbqMLo=;
        b=KOoNaQnzlS7is373aZlIpXHi9c/FdczNBYXNJFlghPA2DuSObQ02XSjoB1IECTklM+
         lu+Dc+nt5KYYNp13+gCQ+cSPlInpBMLEywNBGsksqwRjnrv4SgUO4PXqNuruj9JYNsLm
         kz6tlMgIJDouZH1XfpYKhctzWZ+76XIHOprLbjuymNqrlW+9lhNJvZkyzXwBn0LCXAv1
         bgQrnFzdo87+D0PZ6JlClu2ag5qEUE87IshPvZXHlnIwnO4AHs/bvDfaaqoDHucFvW0c
         JdK7yuvbRLz0qrXD7/fy4fHElKOQlRQjn69aL3tJlmmNO9FR5oavdTLDNvBKbt8YQRmt
         E+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrgKV2laxb7CmMhAO2Zht6dY5cjmqevbQFQ/CfbqMLo=;
        b=VLZZBETgT6d9GEB8RLrFf2diyjh0AM2vTZYtnB9WIBl6tohzcGiZ8kyXmgRAUucWgq
         Iz6hHJXuMcEOOHbTAiVpu/Y4NvWfm2GqfNyZ421dqd/XfL38zELUy6VjGgAolmchwWC0
         nNMXwxy4mLXrKSyEYQiAZxn2eitZdFSW6E3psB1on/5SJWnUZfzSAmyQum8Mt1fcNpve
         G6g1cheJgqisB5rRaKsjNDyOfNZHGdwefkGpZVAVWLNfqGqV7bu1EjjBrmqMGp/q4jpB
         ARdm4SBBbop48FE2vpQPidOG+ptopfjORPxQSfMlEUcqTGBnQRIu3Ds8PIHXcKvTAqIC
         cNUw==
X-Gm-Message-State: APjAAAWN7khl1RBZipxep3/a5BX53JqBXasMtezVWNTHcXBBwp74Edo/
        DC7siHx1cZLS8KiY7gbNSscNt/1s+Y1zmgiTpHcGzw==
X-Google-Smtp-Source: APXvYqzZOm3tnncwSNKOqbGjfZFdhqffwjA+jtK7Mdjt6sdyN+pEm2CYZ51R95H0ZHN2OwG9zQHYDMww4fcojyvf4zk=
X-Received: by 2002:a02:3308:: with SMTP id c8mr4225629jae.103.1561577982127;
 Wed, 26 Jun 2019 12:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-30-matthewgarrett@google.com> <20190626090748.23eba868@gandalf.local.home>
In-Reply-To: <20190626090748.23eba868@gandalf.local.home>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 26 Jun 2019 12:39:31 -0700
Message-ID: <CACdnJuubBJxrybsV6+hyz9RyUR2AUyzy=4WJEeoYrNgbh_=FCQ@mail.gmail.com>
Subject: Re: [PATCH V33 29/30] tracefs: Restrict tracefs when the kernel is
 locked down
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Morris <jmorris@namei.org>, linux-security@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 26, 2019 at 6:07 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 20 Jun 2019 18:19:40 -0700
> Matthew Garrett <matthewgarrett@google.com> wrote:
> > +static const struct file_operations tracefs_proxy_file_operations = {
> > +     .read =         default_read_file,
> > +     .write =        default_write_file,
> > +     .open =         default_open_file,
> > +     .llseek =       noop_llseek,
> > +};
>
> This appears to be unused.

Oops, yup - dropped.

> > +     dentry->d_fsdata = fops ? (void *)fops :
> > +             (void *)&tracefs_file_operations;
> > +     memcpy(proxy_fops, dentry->d_fsdata, sizeof(struct file_operations));
> > +     proxy_fops->open = default_open_file;
> >       inode->i_mode = mode;
> > -     inode->i_fop = fops ? fops : &tracefs_file_operations;
> > +     inode->i_fop = proxy_fops;
>
>
> I think the above would look cleaner as:
>
>
>         if (!fops)
>                 fops = &tracefs_file_operations;
>
>         dentry->d_fsdata = (void *)fops;
>         memcpy(proxy_fops, fops, sizeof(*proxy_fops);
>         proxy_fops->open = default_open_file;

ACK.
