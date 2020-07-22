Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44377228D9B
	for <lists+linux-api@lfdr.de>; Wed, 22 Jul 2020 03:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbgGVB17 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 Jul 2020 21:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731605AbgGVB15 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 Jul 2020 21:27:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE8EC061794
        for <linux-api@vger.kernel.org>; Tue, 21 Jul 2020 18:27:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a15so275212wrh.10
        for <linux-api@vger.kernel.org>; Tue, 21 Jul 2020 18:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=bRQvoGbdo3dxhygTV6fu2sfrlvtgNab4jzf+6Xckq6U=;
        b=e2bVyVFR/luYE2R67F0KZ4prkqXHCEWY4X0byPolSrLQy5+ExyjQNlO0TaCDAlrogk
         ywtjypNipRRa+RLPEo1tPN0VDrawaeMwxGEzRS9zU0N07rMrLp4bqzSDyMitzShsH6Tk
         Ktd1rFj8h6zqyULJesl7lX5jDbQJohEHXxwWJSkwvTw6+0kPofouZKxQpMNOY2aiezOK
         dO8C/MSuAV/8Y94IxHc/2pP/Oln8eMT0nbsbcNR72jPbr3dBQKzsq74O5X8d6/rLO7eZ
         CqdnO+VLyo6ntU2Uxx55zGZ5I2X9y9T4mJqAtLUnMURZxfILI9N3yihJxK+0T330mfiI
         NpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bRQvoGbdo3dxhygTV6fu2sfrlvtgNab4jzf+6Xckq6U=;
        b=c/EWjUegbo0Zs6msxtp7w6u1L1qMklr/4YPVvq3/ssKCK9Ewuk0n1l3wDgrDSwX+7F
         rLh7lYBjjtLpcwZzp4QWoeTrUvHaXZ0m+gtlYx5QTTwkjVeYl8Y/dMCKB7R3U+Qh1HRJ
         AmpPjGnAiaAXfGnz82zSXbPVD721FQXL9T7H3a2tuiTtbSZ9M8w+L5vjq4XrqCNxf210
         z5Y/2BCWKiCV7/7VXqkF4lzi1Mu4Csdg8d2jqo37sc4cWPznBw52y01eVZ8n5Y5Xvbx4
         jZQ6bfaAyszWyutx6SSz0zrIF1hwpynEDhZzO2V3K2Es44mU5dqerD7qTjWuoBdzH5sm
         3BBA==
X-Gm-Message-State: AOAM533d3xeJY1nxOJA82vbPlKt3PjFobI3QhR15bVeveHMS76GNmLxH
        YGIoequ9rIzxu8DtaI321WiVImMMsmzkJ4PF8Yd9WxKRzNs=
X-Google-Smtp-Source: ABdhPJzvXuVYbfolARp5g1IEfs9Adf8adQPazHmsVVB4OZK1/88L/I9jUcQKwvKkMVDOv6ekZbhR2EFUtVFY/WRErQw=
X-Received: by 2002:adf:ec90:: with SMTP id z16mr28800896wrn.52.1595381272662;
 Tue, 21 Jul 2020 18:27:52 -0700 (PDT)
MIME-Version: 1.0
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Tue, 21 Jul 2020 18:27:41 -0700
Message-ID: <CAGbU3_nVvuzMn2wo4_ZKufWcGfmGsopVujzTWw-Bbeky=xS+GA@mail.gmail.com>
Subject: [RFC] fcntl: add description to fdinfo
To:     linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

I am proposing to add a fcntl() command that would allow processes to
"self document" file descriptors - making this description available
through /proc/pid/fdinfo/fd, for netstat, lsof and friends to report.

I don't have experience proposing interface changes. I thought I'd
give more context here first, asking if that makes sense, and if
obvious traps, previous discussions or alternative solutions come to
mind.

The technical implementation I have adds an fcntl command
(F_SET_DESCRIPTION), a description member to struct file, and modifies
show_fdinfo() for the generic proc fd class to eventually report it.

If that sounds reasonable I'll happily follow up with a patch (and a
shorter description)

Thanks!

More context and motivation below:

For monitoring and debugging purposes, and during troubleshooting
sessions, it is often needed to quickly identify the role of an
established socket for a given process, or more globally for a group
of significant sockets, such as all AF_INET/INET6 sockets.

The available tools today let us try to infer this information from
the available (proto, host, port) tuples - but frequently these days
it boils down to HTTPs on generic load balancing or CDN endpoints,
providing little information about what is served behind a socket.

A way to improve that would be to allow processes to self-document
their dependencies, and attach additional information to their
sockets, in the form of a label or description string, somehow in the
same way setproctitle/prctl can be used to give hints about spawned
subprocesses roles.

Example usage/contexts that come to mind:

- netstat, ss, lsof having more details for users
- modern browsers often having lots of open tabs, and service worker
related connections, and a system user trying to identify the source
of some network activity at the time it is observed - reading website
names instead of CDN endpoints
- looking at some remote connections in a distributed system and
knowing the role of a couple stuck Send-Q sockets right away
- remember the intent for a connection (say, the target host of an
HTTP request, a database name, a data channel, ..) before information
is lost during resolution to a destination host, and attach this
information to the socket
