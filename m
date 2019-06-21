Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 721D44EFE1
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 22:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfFUUNv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 16:13:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41011 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUUNv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 16:13:51 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so1081745ioc.8
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZ3HSopZ8scQspbF1YU2hVMlcP6almQVuwJAX1EnWwE=;
        b=uSwOqok2TkKrZs6ef8LyutAmeIVAmrvTX+I0ogpzk10JIgISYRGYFwHbDr/jBjBhcQ
         NA0jqzdzcHT1pNOkAqCHa8QCl44F1pjbQDOu2/zfc8yi+p+kQLK+f7uR4VD/+0cI4wHv
         xyStzMvyDtyEBRWTLynVzKIoWNKAK9B/92biEVIcBuvl9q+1a7EvC4MuZxHvM0O4+pVw
         +fhrIa/DQRoh5GnPuLG3ExEMN3D+SSHaIdgG3OESJHZBWFv0hVuDE2ptMeSG+iW12k/F
         75OD3qMFXdinEJIj3XJYvi/Bjf/DTLErZwwDftSc7wyoG4HP9trMYVkX1zPAwD+mXBb4
         VHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZ3HSopZ8scQspbF1YU2hVMlcP6almQVuwJAX1EnWwE=;
        b=VyARwf+9zB6Oab50bFxoRZZETfzsAsF8/ZAeXE6EQ50AhsYw2mHrOP21yuIimj7Nyz
         5EErovgql0cU4oi8I3YZWLmOjta/HNYDt4H1q8qZhH1FSgCpiD3L6rcW9MX8IyWmtqEw
         hgkjL4i7IF1L4MBsnULKOwDrSY0oaaPV/NCbWLkzDC3AD7AxjxYpP4tm+XZN6ZR9qkJo
         3xePy9MbTYqwsx9v1vLpUdP/oh8MxpWTElnjqosGzQdB2tK7RKLZMWQa2TntYnq23QjI
         f3NHYyuxiunp/wx58hxgNNMvnNw1g2KPF9BZ9MsVXLy4aVS7tgHVhbUUVBwQj72ejiet
         VlaA==
X-Gm-Message-State: APjAAAU25ceiVL9DtfNg95MiFE4AE3Ky0ahoDOz/0AruvmSSI6Hlf+s2
        IZpxJV/GkINNcf3ZPkBThT9So6QlbziKL+Gri5klyw==
X-Google-Smtp-Source: APXvYqyCItlv6yjcz3a4aTv8GzO1ooFirmCSp1fDi4OqQzk3T9nZxw8NBDxszz7jAyO4tbQoJtfUZh4Tl4uzOjWmdAA=
X-Received: by 2002:a02:ab99:: with SMTP id t25mr8431415jan.113.1561148030643;
 Fri, 21 Jun 2019 13:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-7-matthewgarrett@google.com> <20190621063402.GA4528@localhost.localdomain>
In-Reply-To: <20190621063402.GA4528@localhost.localdomain>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 13:13:39 -0700
Message-ID: <CACdnJuvmU8PcRztTYRHes-O3QVwiXy_PQvP9AP=B=byX4Pu3uA@mail.gmail.com>
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

On Thu, Jun 20, 2019 at 11:34 PM Dave Young <dyoung@redhat.com> wrote:
> Force use -EKEYREJECTED is odd,  why not just use original "ret"?

Fair question. Jiri, any feelings here?
