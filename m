Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8372C3EF
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfE1KIN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 06:08:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35696 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfE1KIM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 06:08:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id n14so17227700otk.2
        for <linux-api@vger.kernel.org>; Tue, 28 May 2019 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EX6OLV5ZAUtrIspgTC/dD9s7hQyjTDGZmjCu936OSL8=;
        b=b7HAl2F4pyNTMb75RB18eK82rHnNb7sgimOIYVdxdoBd3KMFC5Gjs9sBasws5mbWSr
         6MvIZ2l2IHj+B6MG2f2G9kG8nd2YTmTKodF/+81DHkSIq1siG+Rr4BEGz+78XEcDvogX
         faTEFwe/nSAFn9Dqy3uSjz+u0TI+Eatyzr+VHJNiT/clF9B7WrAW0rMRYEWj/4JMg6KQ
         JzUaH6ij8XJQ6dygU5bRCXts80yn8/Lqudl+AjGwYmc4F8fM+lMFJEatCRBMytSC7xHo
         WbHYBOCkAjSuq8yim7t//gtzYwulMNqxo/+3ecE5puMtJx9CwNP6PJTnbljhla7FTmOQ
         9xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EX6OLV5ZAUtrIspgTC/dD9s7hQyjTDGZmjCu936OSL8=;
        b=EgcCHBjT57GkCGOEaZDumnJMZDrcEldIQv3CRGd6IfCm6pl5HEqYyyYvaLR8dO4x7k
         gHftTFjNhB2VDFR8XzYNzDbQG1yRh+ZfMBu4ifP6BSGbAPEp+oaWu7HCwPiuL4bMlgxJ
         1H9X7TYdsjtNCD75OgYTT1+7dHozki225ISCVvzxGD0XVe/LH7ZnzfrFsB4rcISZP8vU
         xuD3WY89C4edWmYDvjAHTkJtAw0kRvNQM6XWtNbg6CXyJT+6hoP60dqUJq8g/a4gQZzq
         PUL/J6AxTRFqkilkNKZfECEyO7QAmu3MdSlmL8DUuGwfjJ9zzEYKpdRlmVNuLjGCFgXD
         FiaQ==
X-Gm-Message-State: APjAAAUFkhL1eIYJ2aa5GHqmzho3eCNyyhEpgO5QPiaqn3CzO5qy8ha2
        TX4MqOa3VLJUZQw6zL9mTEQv6w==
X-Google-Smtp-Source: APXvYqy+CVLW4qcGF5HZbujWnRF7l0dKamIr0LRxh4BCVKOiOumpEkoC7xrroBljDS1vYgtKHhWhrw==
X-Received: by 2002:a9d:5a14:: with SMTP id v20mr4657355oth.356.1559038092169;
        Tue, 28 May 2019 03:08:12 -0700 (PDT)
Received: from brauner.io ([172.56.7.242])
        by smtp.gmail.com with ESMTPSA id q21sm4633894ota.24.2019.05.28.03.08.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 03:08:11 -0700 (PDT)
Date:   Tue, 28 May 2019 12:08:04 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/2] fork: add clone6
Message-ID: <20190528100802.sdfqtwrowrmulpml@brauner.io>
References: <20190526102612.6970-1-christian@brauner.io>
 <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
 <20190527104239.fbnjzfyxa4y4acpf@brauner.io>
 <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 27, 2019 at 12:27:08PM -0700, Linus Torvalds wrote:
> On Mon, May 27, 2019 at 3:42 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > Hm, still pondering whether having one unsigned int argument passed
> > through registers that captures all the flags from the old clone() would
> > be a good idea.
> 
> That sounds like a reasonable thing to do.
> 
> Maybe we could continue to call the old flags CLONE_XYZ and continue
> to pass them in as "flags" argument, and then we have CLONE_EXT_XYZ
> flags for a new 64-bit flag field that comes in through memory in the
> new clone_args thing?

Hm. I think I'll try a first version without an additional register
flags argument. And here's why: I'm not sure it buys us a lot especially
if we're giving up on making this convenient for seccomp anyway.
And with that out of the way (at least for the moment) I would really
like to make this interface consistent. But we can revisit this when I
have the code.

Christian
