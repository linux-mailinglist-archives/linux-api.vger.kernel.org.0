Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1324C123F5
	for <lists+linux-api@lfdr.de>; Thu,  2 May 2019 23:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfEBVPg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 May 2019 17:15:36 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56282 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBVPg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 May 2019 17:15:36 -0400
Received: by mail-it1-f193.google.com with SMTP id i131so5943876itf.5
        for <linux-api@vger.kernel.org>; Thu, 02 May 2019 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOv6I9+ls0pg/L2LNTaF96Fgd3up03vC2d8X1+k10Jw=;
        b=uvZDTO/qh64JrJcIkvq/4aiOSsw8Q0MsZnjxBm9sZiYPEaSC5Np2Wo1GcTWOQ+u8ua
         hEMRKpS2KWAT3dnc3mJ3W9x2c9zrMfEah06LjsvZRIS9oHkvyrz4dGYO+j6NO4y9sztq
         rGRFCDcUMjr7K+5d1OTLG/+y+Z6/P/J7FfyCY33gvI76Z1EtA9kLA6Qr3Ah5xSafeD7L
         rn90/7Oxfc+zVew4pqQSP65HE62lJBgDMgHtLFYubHCLfWV/2UhQkeKD5y30/kj4jVQ2
         g44lf9J8i86iUBu7OAM6W70hfxqdfPARM1zJthsfCLvd5Y7aW2lpcfVvLz6dF7bM0plU
         16Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOv6I9+ls0pg/L2LNTaF96Fgd3up03vC2d8X1+k10Jw=;
        b=LdlcaG1tPactfGdCpsFE1hUB6eWUijTiybw2u5ywnVdqn4nRJe0Sw6V/joV9gTad+w
         l0mv4+KLQjgz8+KsegBivXVlXcBp6StcKUnp5DnxOvWiVpgtWaXvCVLLgvmXj+FtC2Uj
         ZOyRrjcmKZhsETKUQIaAYtj32EF1lxlVqhJYvvZ8romW9LMyrKVixJSnxcJr5usDIaWP
         +2L8LKzwjwRQd21Do1UzhOWfotyId9DnSjS6uDM7Udy3k+2S54SJWlk45ZuYM1utDchA
         l6pJd3OsmxwDMChhXDQNX6dSqyR0ZbFkBvH3n89lWibbo7AbPQPyS/sxCiFFi+qX1CZw
         j4CQ==
X-Gm-Message-State: APjAAAUaEsHGDJWARUj9N0zq7nyrVQvzT+uCgkFKEaqy67VC/nrcncOE
        3A5LP93YzK5tCjFr+2GxhW47UQSj8FWQPP5FvkVwRA==
X-Google-Smtp-Source: APXvYqzfwJniKNWcSzyn9xHnDRujlzoA6z9dBIzSGvJjoxZ4tSKU0QrYgIKizaFoffmvIPBtAp6YQAp4PV525jIfHOw=
X-Received: by 2002:a24:eb04:: with SMTP id h4mr4550431itj.16.1556831734903;
 Thu, 02 May 2019 14:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
 <20190404003249.14356-2-matthewgarrett@google.com> <CACdnJus-+VTy0uOWg982SgZr55Lp7Xot653dJb_tO5T=J6D8nw@mail.gmail.com>
 <alpine.LRH.2.21.1905030653480.32502@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905030653480.32502@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 2 May 2019 14:15:23 -0700
Message-ID: <CACdnJuusGU2DMXaPAjH3+QOcSj-9q6njbxxG-9s2PweDKognvw@mail.gmail.com>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 2, 2019 at 2:07 PM James Morris <jmorris@namei.org> wrote:
> One possible direction is to (as previously mentioned) assign IDs to each
> callsite and be able to check this ID against a simple policy array
> (allow/deny).  The default policy choices could be reduced to 'all' or
> 'none' during kconfig, and allow a custom policy to be loaded later if
> desired.

Ok. My primary concern around this is that it's very difficult to use
correctly in anything other than the "all" or "none" modes. If a new
kernel feature is added with integrated lockdown support, if an admin
is simply setting the flags of things they wish to block then this
will be left enabled - and may violate the admin's expectations around
integrity. On the other hand, if an admin is simply setting the flags
of things they wish to permit, then adding lockdown support to an
existing kernel feature may result in that feature suddenly being
disabled, which may also violate the admin's expectations around the
flags providing a stable set of behaviour.

Given that, would you prefer such a policy expression to look like?

> Within the policy check hook, we could add a new LSM hook, which would
> allow an LSM to restrictively override the lockdown policy with its own

Ok, that makes sense. If we take this approach, does there need to be
a separate policy mechanism at all? Users who want fine-grained
control would be able to set the behaviour to "None" and then use
their choice of LSM to express more fine-grained control.

> This doesn't really address the completeness / maintenance issue (i.e. "do
> we have everything covered and how do we ensure this on an ongoing
> basis?", and "what will this new lockdown feature break?"), although it
> should make it easier to add new lockdown callsites as they don't have to
> be enabled by the user.

I can start on this.
