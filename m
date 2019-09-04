Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC7EA96A2
	for <lists+linux-api@lfdr.de>; Thu,  5 Sep 2019 00:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfIDWny (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Sep 2019 18:43:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41230 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIDWnx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Sep 2019 18:43:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id a4so333552ljk.8
        for <linux-api@vger.kernel.org>; Wed, 04 Sep 2019 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFDhCyHzhyiLnyceYcteUHqOXGgh38Kg6TIOg9RDlV8=;
        b=GnnwuO2FC8JvRpMBdQIyMOw63KWp0i8RWU7BAf9vhwmdfauk+kGPRrhGsnlnlPAmBt
         Cx6hzCIVK4L+kzxznEGXiVTPGueSaoLKTwELcbVCO2oVI6bZuWttjzsqT9tZPNkgY/TA
         7QyH0CjS5KTQcx4hIjs9o8ztIuxjlBT486QSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFDhCyHzhyiLnyceYcteUHqOXGgh38Kg6TIOg9RDlV8=;
        b=dU2RMYemotDb9QFWuWRYt1fUkb0uDC39f7yJJ5FnJoNP/S6M5mEtIPgYaXfv1w5vkX
         caRPFUo/bJiFMGyHeJTHtaYnvg4jjybptjzc5mXOM+9F/qjlEvNft4XiyExCfIkZrKPB
         pY9kK3iAWNCMev/e0qqmeIZRN5lmJE/AHc5N6kHvI8ZKyeLn0ojC7RTpW1RMcjZu2UVB
         EblFuJPzyrD0DKi7w6PGvmTx1pUEdnO8wfjcC4uUo/XVlQZpfZO1OOyCcAjc1/UkpOyf
         JMY9K3AtZ7J+9Wpd7KGVvX7NjrDvJVGUZCkltYos8I3TDEpeXLvl1xXCjOQoj2YZHWfR
         xbaA==
X-Gm-Message-State: APjAAAXiDOqsTVO4SGrTvWlRdzsSA5iGp59YHNXCh7TKHkkHFbS84QSL
        3WpjdFKkJkNWLGJQPILczqp/ZmumbP4=
X-Google-Smtp-Source: APXvYqwLLCb7HBDD3zBT1z/PBBn14otA9SW5JVXFzMTWU94jphTZc1ywI1vjRfu3xNewBtWHIoIpkg==
X-Received: by 2002:a05:651c:1135:: with SMTP id e21mr16377ljo.83.1567637031697;
        Wed, 04 Sep 2019 15:43:51 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id v1sm43507lfq.89.2019.09.04.15.43.51
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 15:43:51 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id l1so308186lji.12
        for <linux-api@vger.kernel.org>; Wed, 04 Sep 2019 15:43:51 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr24885ljg.72.1567636715921;
 Wed, 04 Sep 2019 15:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-11-cyphar@cyphar.com>
 <CAHk-=wiod1rQMU+6Zew=cLE8uX4tUdf42bM5eKngMnNVS2My7g@mail.gmail.com>
 <20190904214856.vnvom7h5xontvngq@yavin.dot.cyphar.com> <CAHk-=wgcJq21Hydh7Tx5-o8empoPp7ULDBw0Am-du_Pa+fcftQ@mail.gmail.com>
 <20592.1567636276@warthog.procyon.org.uk>
In-Reply-To: <20592.1567636276@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Sep 2019 15:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7Wq1kj8kZ+SSpfU_o991woW60NWca9yBA2ccs2eNx8Q@mail.gmail.com>
Message-ID: <CAHk-=wg7Wq1kj8kZ+SSpfU_o991woW60NWca9yBA2ccs2eNx8Q@mail.gmail.com>
Subject: Re: [PATCH v12 10/12] namei: aggressively check for nd->root escape
 on ".." resolution
To:     David Howells <dhowells@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 4, 2019 at 3:31 PM David Howells <dhowells@redhat.com> wrote:
>
> It ought to be reasonably easy to make them per-sb at least, I think.  We
> don't allow cross-super rename, right?

Right now the sequence count handling very much depends on it being a
global entity on the reader side, at least.

And while the rename sequence count could (and probably should) be
per-sb, the same is very much not true of the mount one.

So the rename seqcount is likely easier to fix than the mount one, but
neither of them are entirely trivial, afaik.

               Linus
