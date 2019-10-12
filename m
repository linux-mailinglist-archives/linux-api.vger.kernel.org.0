Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77CEAD5332
	for <lists+linux-api@lfdr.de>; Sun, 13 Oct 2019 00:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfJLW4g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 18:56:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33762 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfJLW4f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 12 Oct 2019 18:56:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so13164201ljd.0
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 15:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DS67+YtCVu11SuWVZgu6Ket3y4/O2UgURNPso78w8e8=;
        b=Z8HBphVPrHzEotVK6GhCCdwuVASP2gvXWc76WJqSndGHM9/B/9mi8kNS+A5t2InmtF
         MSVj/sXqsezE6utbTZrIaBDDElGeUbMDMKgEzYvCnBg0wzL77Air9Ng/uDpX3dFDH/M6
         +8ki0dUOVg8W1BriNCEuKJeWIJUE+8QWI0I6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DS67+YtCVu11SuWVZgu6Ket3y4/O2UgURNPso78w8e8=;
        b=NKMvSmz0JTDDUMbMLnD5qmHNWT6J2kzlyDGLaNAZNErxO+SjN46QhZW4JY51lm+EX1
         Go21zGSgYMpdNmeFJB3qydi24d+NpxlUKYRmfgS1HnZwlbiyqTw0/oeXGS9G4suKvZ7l
         zVgMbNzf09LbMwNw7mPsOJ+yo3h6yhCxp+pfWtDaGwgiyx19/qTLsNybr5aUvPVdmVFw
         UdAgJiAPc1kJFkpQNa0b072yWedH0pLfSShcBle8E8FGZhhizGnVFHLhP0qqhU3c3D0w
         aDd8XeY7rEJsUi6H1pi0Z8YIoPoM72J7TieeBzps8BnieOXE942UAZ4Nqk9Nit22aVhs
         S+6A==
X-Gm-Message-State: APjAAAVJL1jQdxE8eDZ4+ggO9FpkTPVmVQ5sv230zl6211PkDt04xyF0
        63jRQ8gINHOUhnnSaHYUeT7RWmqKjo0=
X-Google-Smtp-Source: APXvYqw3jY7nqBGszkvTKC45LdRm6rPlvf4tQQTEh7tcKZ1+oJ2Ty/6TFnSILOcgACpmh9uoES4mWQ==
X-Received: by 2002:a2e:331a:: with SMTP id d26mr13088971ljc.231.1570920994011;
        Sat, 12 Oct 2019 15:56:34 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w18sm288000ljd.99.2019.10.12.15.56.31
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2019 15:56:32 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id w67so9377373lff.4
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 15:56:31 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr12727917lfc.79.1570920991283;
 Sat, 12 Oct 2019 15:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191012005747.210722465@goodmis.org> <20191012005920.630331484@goodmis.org>
In-Reply-To: <20191012005920.630331484@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Oct 2019 15:56:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE7GjKz9LtEVNw=zEgWr65N1mU7t2rA4MLiia8Zit6DQ@mail.gmail.com>
Message-ID: <CAHk-=whE7GjKz9LtEVNw=zEgWr65N1mU7t2rA4MLiia8Zit6DQ@mail.gmail.com>
Subject: Re: [PATCH 1/7 v2] tracefs: Revert ccbd54ff54e8 ("tracefs: Restrict
 tracefs when the kernel is locked down")
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 11, 2019 at 5:59 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> I bisected this down to the addition of the proxy_ops into tracefs for
> lockdown. It appears that the allocation of the proxy_ops and then freeing
> it in the destroy_inode callback, is causing havoc with the memory system.
> Reading the documentation about destroy_inode and talking with Linus about
> this, this is buggy and wrong.

Can you still add the explanation about the inode memory leak to this message?

Right now it just says "it's buggy and wrong". True. But doesn't
explain _why_ it is buggy and wrong.

          Linus
