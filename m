Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75181D5337
	for <lists+linux-api@lfdr.de>; Sun, 13 Oct 2019 01:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfJLXJI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 19:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfJLXJI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 12 Oct 2019 19:09:08 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93027206A1
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570921747;
        bh=GAvUJfnQ/ekmzshI/omTNt5MUxVTCo8T6Nqip48DUX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JTyhSfROnYDV6+Fth3ItctGOlNGKlHg/NSCLvHkvRwrwr1hsSiDJki3bnbFJrIJ2a
         bbnhD2g/xO/69ixGIHPfmhJoNSkRheQGxPXc/gdC+Ww69/D3k6b3Q917TraxadWcix
         Zt5ZiliVWcn1tAvzirg5XTa5QDZ7CM9ABgbnRlLc=
Received: by mail-wr1-f48.google.com with SMTP id r5so15512589wrm.12
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 16:09:07 -0700 (PDT)
X-Gm-Message-State: APjAAAVx6dRFY+Sxk9zcpQ+XUac7As/zFPjXXfU+PThdRAINjAmR+0fX
        I7y0yRurT1Hd+JW+tJvASkvFQasJtrXo4x4odw6ziQ==
X-Google-Smtp-Source: APXvYqwToLzAnzQSsxAZzU4NTPQigPb3yanedeLHemgxicJ+jgCUwUmcHIr/UI5jamm/XXVoeZciNh4Pn5bou9O+JlU=
X-Received: by 2002:a5d:6949:: with SMTP id r9mr16124264wrw.106.1570921746082;
 Sat, 12 Oct 2019 16:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-5-dancol@google.com>
In-Reply-To: <20191012191602.45649-5-dancol@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 12 Oct 2019 16:08:54 -0700
X-Gmail-Original-Message-ID: <CALCETrVmYQ9xikif--RSAWhboY1yj=piEAEuPzisf+b+qEX4uA@mail.gmail.com>
Message-ID: <CALCETrVmYQ9xikif--RSAWhboY1yj=piEAEuPzisf+b+qEX4uA@mail.gmail.com>
Subject: Re: [PATCH 4/7] Teach SELinux about a new userfaultfd class
To:     Daniel Colascione <dancol@google.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lokeshgidra@google.com,
        Nick Kralevich <nnk@google.com>, nosh@google.com,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
>
> Use the secure anonymous inode LSM hook we just added to let SELinux
> policy place restrictions on userfaultfd use. The create operation
> applies to processes creating new instances of these file objects;
> transfer between processes is covered by restrictions on read, write,
> and ioctl access already checked inside selinux_file_receive.

This is great, and I suspect we'll want it for things like SGX, too.
But the current design seems like it will make it essentially
impossible for SELinux to reference an anon_inode class whose
file_operations are in a module, and moving file_operations out of a
module would be nasty.

Could this instead be keyed off a new struct anon_inode_class, an
enum, or even just a string?

--Andy
