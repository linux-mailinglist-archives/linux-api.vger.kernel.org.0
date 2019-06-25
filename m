Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0051F6F
	for <lists+linux-api@lfdr.de>; Tue, 25 Jun 2019 02:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfFYACm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 20:02:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43451 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfFYACl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 20:02:41 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so79887ios.10
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 17:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNvnHjVZLeBkwx5DnxrnXY0O9TQzHKxcjR8STK/P0sU=;
        b=bWPW7sdarMCTWE6gvhCS4q5QKL5i1C9X/hSDjFhEqHaKX+WmSlTqzwUceTojfRVNUr
         zywbp91SXq6A+duFsrFbDYbj+v+Wrx17PIIaCFMnm7d2JtOfSum3AYB7WHgA8AAbuqWi
         hxdcyYR4dlz2SA27CV8fZOGRzl4123Sx/1HlAj+2oOnIKDEFan1aaahPCrAuyRremyM7
         wG9vIE3BuvBF4dcemLdw/39QJTHX52qb1b1i5qvru5PYtN5F1Ddi1+RLlqP4D6LgArFm
         YhV6hPojZU+QHyRSv1M9+UhHbltHd3TKR3s4FtFGRmnuACTDOtQOa9aG51TNRpXrDb2Q
         9pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNvnHjVZLeBkwx5DnxrnXY0O9TQzHKxcjR8STK/P0sU=;
        b=devhxQi0jQsoaTu5wK0fvPE6AmPqWClcxbFCeNIB5IJiDvYHPLor+ZwJtqMHCt8a6I
         HwBJvbQigKgOXs6nGywA3R2k6EgbpsJdNxbTwgftKyG/3ePc+QzUDWJYtq/OClx9i54S
         61+RWvjnKyF6sQfGeBpwA9Bd3AbBjLi9ZiedOWI7ZOESehHqB5KR41RTAIXyVq95HZT8
         8NdMYorCYcyvhnJ7ZCNNvQrQmK7L0/t80CaELAvKihb8p2TMQqMz9PnndMRcW825sZaV
         eMCxkO8Vn10COaHqE4rlbbRVqHmT2PBLQzY+jSBl+Jc8G1uHWooQ7VfG+SZOHF9fvxDh
         bbRg==
X-Gm-Message-State: APjAAAXOJJD3BIEIMZ6fyahp71SYEVMl5IP51zNXZ1wP9kR9SKUAZRyw
        CMfVmYN63Zf9JMxRkcImqZRlBim84gj0cgUpC5Y0+w==
X-Google-Smtp-Source: APXvYqxn3MVYC4ak7P+FllAR9bmNMszhCgsJC5oAjv3dI9GMqJC0QI1X8HPkw9B+ufAiKnMKPJqF/HKmWkQdx4h5yk8=
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr3074338ion.204.1561420960582;
 Mon, 24 Jun 2019 17:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com> <20190621064340.GB4528@localhost.localdomain>
 <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
 <20190624015206.GB2976@dhcp-128-65.nay.redhat.com> <CACdnJusPtYLdg7ZPhBo=Y5EsBz6B+5M2zYscBrLcc89oNnPkdQ@mail.gmail.com>
 <1561411657.4340.70.camel@linux.ibm.com>
In-Reply-To: <1561411657.4340.70.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 24 Jun 2019 17:02:29 -0700
Message-ID: <CACdnJuvE-MbD42AJTrio=0RaN8SaWo-RHHt21z=3an1vtjTFhA@mail.gmail.com>
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dave Young <dyoung@redhat.com>, James Morris <jmorris@namei.org>,
        Jiri Bohac <jbohac@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 24, 2019 at 2:27 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> I agree with Dave.  There should be a stub lockdown function to
> prevent enforcing lockdown when it isn't enabled.

Sorry, when what isn't enabled? If no LSMs are enforcing lockdown then
the check will return 0. The goal here is for distributions to be able
to ship a kernel that has CONFIG_KEXEC_SIG=y, CONFIG_KEXEC_SIG_FORCE=n
and at runtime be able to enforce a policy that requires signatures on
kexec payloads.
