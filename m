Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA84EFE8
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 22:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFUUPL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 16:15:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34371 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfFUUPK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 16:15:10 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so55897iot.1
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzDlMHYKYdPbav08td6cmrqKH87QGtCYlyXDXXOTgFk=;
        b=tQXWoCT7u5RD2XblRn/rEN/phOj7fWsEmz5uMzn5kiCQyibx9ujzvtEvgK6iZ8pwsm
         mf7OLToqshhDbzAdX8fnx8gG5wXPsbUk2uRMl5dBsMdWEHD5Z+LF4KSJeakOOmCxbyZP
         C6E9MxZMnuitfO1C+d0TwHhQljoRubGQLCDZYiIC3Ru4fpIkiiQkIkjVkjh6d65rgarv
         ZRAFTDUIefuKONBucRjVJjnw6fjoaa2gcyJQ0Coo8bG0g6t7lRYItK9Bw4q0CDU0gNf4
         Zsbfow4kziPBKI25UKNcswXRd9uGeYPOmcGp6uvJ5+a1qIP4KwCzcIEieVzY6BjgRFNo
         86nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzDlMHYKYdPbav08td6cmrqKH87QGtCYlyXDXXOTgFk=;
        b=UqQAwtD8k8DGQcimv2OnruFr0Nl1hgtmv+NIyekKukAoKa8Cyio8cVTilV6de1/klH
         zARMVXKE5zkgjM1QVPLDA4wwzhPioVXJa3eja/m+AQjQqopOcw/0AWE0AJe9ESUAUjsw
         5ZTTZ64PVYZAqLgnnaS2XJEqBeeTsBWepsHkxQiXuGaqujL2v1LBiFs3kaf6u87fCGVB
         A2QrZaSes329pvSzoB3smMWXfBx3wdYh3Obe6pchSr25C1CgZERKEq3EwQPl1X8bTIzY
         Nt4H6LlaEvPko8lsUxuRCImGOT3rMcJylxEyuFuLeRrMV0L5ijlrFCiTHHqAFQs5fw+N
         n0DA==
X-Gm-Message-State: APjAAAXr9nXAo0e6RqXSQ2CefiP7+/kYup8vgcqoqWnXnOC9tluiiqhq
        P9B6w+7Ife1EgIzhtaLK2qI4Tjg3u7PeOZK7rdvqRQ==
X-Google-Smtp-Source: APXvYqzER/6ghfGh+cCnTzWqlcRB44urm1l0GO8Y6AzN702AqR5wrDwl3TwRIfhgqi7cB1Nz5b8PL34nNbf3GVcacss=
X-Received: by 2002:a05:6602:220d:: with SMTP id n13mr19253423ion.104.1561148108546;
 Fri, 21 Jun 2019 13:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-7-matthewgarrett@google.com> <20190621063402.GA4528@localhost.localdomain>
 <CACdnJuvmU8PcRztTYRHes-O3QVwiXy_PQvP9AP=B=byX4Pu3uA@mail.gmail.com>
In-Reply-To: <CACdnJuvmU8PcRztTYRHes-O3QVwiXy_PQvP9AP=B=byX4Pu3uA@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 13:14:57 -0700
Message-ID: <CACdnJusyS=bHXTYMxQWObVL6rzGnh1g3KETayh0wyVEYdcjnpA@mail.gmail.com>
Subject: Re: [PATCH V31 06/25] kexec_file: split KEXEC_VERIFY_SIG into
 KEXEC_SIG and KEXEC_SIG_FORCE
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Jiri Bohac <jbohac@suse.cz>,
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

On Fri, Jun 21, 2019 at 1:13 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Thu, Jun 20, 2019 at 11:34 PM Dave Young <dyoung@redhat.com> wrote:
> > Force use -EKEYREJECTED is odd,  why not just use original "ret"?
>
> Fair question. Jiri, any feelings here?

Actually, looks like this change was made by Dave Howells.
