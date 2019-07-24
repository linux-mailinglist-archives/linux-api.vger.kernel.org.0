Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D690735C2
	for <lists+linux-api@lfdr.de>; Wed, 24 Jul 2019 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfGXRp7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jul 2019 13:45:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45849 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfGXRp7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jul 2019 13:45:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so32531921lfm.12
        for <linux-api@vger.kernel.org>; Wed, 24 Jul 2019 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95+Ojj8whLDzTQfSvFpUfZPQNS2ad16YlfE2wY3FNvs=;
        b=Q1otmVXyrcOvARrNHCq3mme+hGOPc0EnMeptu7eG3VCcjT/HkP54TR+dyDnM4qL9d5
         FonTz95jDa6pthaSmRyHWkpw1Tde3zEXeGdzrSTuS5RS8pvNtLbrl34+D57HnUjtTzDS
         e7q295+fYzIVl3K0F+jR//YtMKvddGwPmrsD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95+Ojj8whLDzTQfSvFpUfZPQNS2ad16YlfE2wY3FNvs=;
        b=J3BgvDHXm3ZPkVqsk6dTH1mm6I3hEqCUAcX592ehmCJvgTGXF5Oas5DPeijkBCUhrx
         2sAPRwmJSFh3KdHsjCBflT8T1nyDlXQaoOqUgCrlk0S/Vc39dkkLt03qeyHHjV5pxu5U
         k2qjbQoyyNioSqFvKDvzJJZe1+Ij9C4YouYaR3VuF7sxeVlV52UCtUBMiTnIvQZ3+ZPe
         PvkhUm5C41omcbOXlfHvh5JT3rwi2H/2bGOz5LoTwg249usD1gCsy6VHq08gOf6p7/oR
         wo+nreodh34/fJykqhsit+6L2awVJ0WUGQfNFRWi6Bf2jSQuPDjZqUEQYb40mMVtJQfb
         oXFA==
X-Gm-Message-State: APjAAAX0mb6+1QSPaFLMu4KHL3IiFqI7G7YminypOuc3h9knmclc6880
        VL0lj4PFJtGZ712ZFjQ9ECnhbN9aj98=
X-Google-Smtp-Source: APXvYqyKmN2Erj096wJP43WBlFeTW/KkCM3jX8+K46S6o/Mjcp3JQhGiDPeAv0wKomfwQ+ClHQP+uw==
X-Received: by 2002:ac2:4c82:: with SMTP id d2mr21159949lfl.89.1563990357052;
        Wed, 24 Jul 2019 10:45:57 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v14sm8688869ljh.51.2019.07.24.10.45.54
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:45:54 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id p17so45344860ljg.1
        for <linux-api@vger.kernel.org>; Wed, 24 Jul 2019 10:45:54 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr44841672ljj.156.1563990354068;
 Wed, 24 Jul 2019 10:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-3-christian@brauner.io>
In-Reply-To: <20190724144651.28272-3-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jul 2019 10:45:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
Message-ID: <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner <christian@brauner.io> wrote:
>
> This adds the pidfd_wait() syscall.

I despise this patch.

Why can't this just be a new P_PIDFD flag, and then use
"waitid(P_PIDFD, pidfd, ...);"

Yes, yes, yes, I realize that "pidfd" is of type "int", and waitid()
takes an argument of type pid_t, but it's the same type in the end,
and it does seem like the whole *point* of "waitid()" is that
"idtype_t idtype" which tells you what kind of ID you're passing it.

               Linus
